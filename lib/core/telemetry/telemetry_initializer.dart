import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

import '../utils/app_logger.dart';
import 'telemetry_config.dart';
import 'telemetry_service.dart';
import '../analytics/noop_analytics_service.dart';
import '../crash_reporting/noop_crash_reporting_service.dart';
import '../analytics/firebase_analytics_service.dart';
import '../crash_reporting/firebase_crash_reporting_service.dart';

class TelemetryInitializer {
  static Future<TelemetryService> initialize(TelemetryConfig config) async {
    AppLogger.log('Initializing Telemetry Module...');

    if (config.firebaseEnabled) {
      try {
        await Firebase.initializeApp();
        
        final crashReporting = FirebaseCrashReportingService(config: config.crashReportingConfig);
        final analytics = FirebaseAnalyticsService(config: config.analyticsConfig);

        _configureErrorCatching(crashReporting, config);

        return TelemetryService(
          analytics: analytics,
          crashReporting: crashReporting,
        );
      } catch (e, st) {
        if (config.useNoopWhenFirebaseUnavailable) {
          AppLogger.error('Firebase initialization failed. Falling back to Noop Telemetry. Did you forget google-services.json/GoogleService-Info.plist?', e, st);
          return _fallbackNoop(config);
        } else {
          rethrow;
        }
      }
    } else {
      return _fallbackNoop(config);
    }
  }

  static TelemetryService _fallbackNoop(TelemetryConfig config) {
    return TelemetryService(
      analytics: NoopAnalyticsService(config: config.analyticsConfig),
      crashReporting: NoopCrashReportingService(config: config.crashReportingConfig),
    );
  }

  static void _configureErrorCatching(FirebaseCrashReportingService crashReporting, TelemetryConfig config) {
    if (!config.crashReportingConfig.enabled) return;

    if (config.crashReportingConfig.recordFlutterFatalErrors || config.crashReportingConfig.recordFlutterNonFatalErrors) {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        final fatal = errorDetails.exception is Exception ? false : true; // Heuristic
        crashReporting.recordError(
          errorDetails.exception,
          errorDetails.stack,
          fatal: fatal,
          reason: errorDetails.context?.toString(),
          information: {}, // Will be handled by the original handler or we could map errorDetails.information
        );
        if (originalOnError != null) {
          originalOnError(errorDetails);
        }
      };
    }

    if (config.crashReportingConfig.recordPlatformErrors) {
      PlatformDispatcher.instance.onError = (error, stack) {
        crashReporting.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }
}
