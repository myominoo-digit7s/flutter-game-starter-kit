import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../utils/app_logger.dart';
import 'crash_reporting_config.dart';
import 'crash_reporting_service.dart';

class FirebaseCrashReportingService implements CrashReportingService {
  final CrashReportingConfig config;
  final FirebaseCrashlytics _crashlytics;

  FirebaseCrashReportingService({
    required this.config,
    FirebaseCrashlytics? crashlytics,
  }) : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  void _log(String message) {
    if (config.debugLoggingEnabled) {
      AppLogger.log('[FirebaseCrashReporting] $message');
    }
  }

  @override
  Future<void> initialize() async {
    _log('Initialized FirebaseCrashReportingService');
    await setCrashCollectionEnabled(config.enabled);
  }

  @override
  Future<void> setCrashCollectionEnabled(bool enabled) async {
    try {
      await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
      _log('Set Crash Collection Enabled: $enabled');
    } catch (e, st) {
      AppLogger.error('Failed to set crash collection enabled', e, st);
    }
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
    Map<String, Object?> information = const {},
  }) async {
    if (!config.enabled) return;
    if (fatal && !config.recordFlutterFatalErrors) return;
    if (!fatal && !config.recordFlutterNonFatalErrors) return;

    try {
      _log('Recording error (fatal: $fatal)');
      
      // Convert map to iterable of diagnostics node if needed, but Crashlytics supports simple information parameter
      final formattedInfo = information.entries
          .map((e) => DiagnosticsNode.message('${e.key}: ${e.value}'))
          .toList();

      await _crashlytics.recordError(
        error,
        stackTrace,
        fatal: fatal,
        reason: reason,
        information: formattedInfo,
      );
    } catch (e, st) {
      AppLogger.error('Crashlytics failed to record error', e, st);
    }
  }

  @override
  Future<void> log(String message) async {
    if (!config.enabled) return;
    try {
      await _crashlytics.log(message);
    } catch (e, st) {
      AppLogger.error('Crashlytics failed to log message', e, st);
    }
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    if (!config.enabled) return;
    try {
      await _crashlytics.setCustomKey(key, value);
    } catch (e, st) {
      AppLogger.error('Crashlytics failed to set custom key', e, st);
    }
  }

  @override
  Future<void> setUserIdentifier(String identifier) async {
    if (!config.enabled) return;
    try {
      await _crashlytics.setUserIdentifier(identifier);
    } catch (e, st) {
      AppLogger.error('Crashlytics failed to set user identifier', e, st);
    }
  }
}
