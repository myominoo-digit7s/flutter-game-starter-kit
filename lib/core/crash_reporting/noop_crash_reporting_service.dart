import '../utils/app_logger.dart';
import 'crash_reporting_config.dart';
import 'crash_reporting_service.dart';

class NoopCrashReportingService implements CrashReportingService {
  final CrashReportingConfig config;

  NoopCrashReportingService({required this.config});

  void _log(String message) {
    if (config.debugLoggingEnabled) {
      AppLogger.log('[NoopCrashReporting] $message');
    }
  }

  @override
  Future<void> initialize() async {
    _log('Initialized NoopCrashReportingService');
  }

  @override
  Future<void> setCrashCollectionEnabled(bool enabled) async {
    _log('Crash collection enabled: $enabled');
  }

  @override
  Future<void> recordError(Object error, StackTrace? stackTrace, {bool fatal = false, String? reason, Map<String, Object?> information = const {}}) async {
    if (!config.enabled) return;
    if (fatal && !config.recordFlutterFatalErrors) return;
    if (!fatal && !config.recordFlutterNonFatalErrors) return;

    _log('Recorded Error (fatal: $fatal) - $error\nReason: $reason\nInfo: $information');
  }

  @override
  Future<void> log(String message) async {
    if (!config.enabled) return;
    _log('Log: $message');
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    if (!config.enabled) return;
    _log('Set Custom Key: $key = $value');
  }

  @override
  Future<void> setUserIdentifier(String identifier) async {
    if (!config.enabled) return;
    _log('Set User Identifier: [ANONYMIZED/LOCAL]');
  }
}
