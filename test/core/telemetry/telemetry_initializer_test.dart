import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/telemetry/telemetry_config.dart';
import 'package:flutter_game_starter_kit/core/telemetry/telemetry_initializer.dart';
import 'package:flutter_game_starter_kit/core/analytics/noop_analytics_service.dart';
import 'package:flutter_game_starter_kit/core/crash_reporting/noop_crash_reporting_service.dart';

void main() {
  group('TelemetryInitializer', () {
    test('Firebase is disabled by default for a new game', () async {
      const config = TelemetryConfig();

      expect(config.firebaseEnabled, isFalse);
      final service = await TelemetryInitializer.initialize(config);

      expect(service.analytics, isA<NoopAnalyticsService>());
      expect(service.crashReporting, isA<NoopCrashReportingService>());
      await service.analytics.logAppOpen();
      await service.analytics.logGameStart(
        gameId: 'test_game',
        gameName: 'Test Game',
      );
    });

    // Firebase initialization requires bindings and real google-services.json
    // We only test the Noop fallback path here since Firebase app init fails without config
    test(
      'Initialization falls back to Noop when Firebase fails if useNoopWhenFirebaseUnavailable is true',
      () async {
        // Because we haven't initialized FlutterFire correctly in the test environment,
        // Firebase.initializeApp() will throw a FirebaseException.
        final config = const TelemetryConfig(
          firebaseEnabled: true,
          useNoopWhenFirebaseUnavailable: true,
        );
        final service = await TelemetryInitializer.initialize(config);

        expect(service.analytics, isA<NoopAnalyticsService>());
        expect(service.crashReporting, isA<NoopCrashReportingService>());
      },
    );
  });
}
