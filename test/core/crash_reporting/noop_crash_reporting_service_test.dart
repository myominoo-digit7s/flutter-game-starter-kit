import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/crash_reporting/crash_reporting_config.dart';
import 'package:flutter_game_starter_kit/core/crash_reporting/noop_crash_reporting_service.dart';

void main() {
  group('NoopCrashReportingService', () {
    test('Initialization works without errors', () async {
      final service = NoopCrashReportingService(config: const CrashReportingConfig());
      expect(() => service.initialize(), returnsNormally);
    });

    test('recordError works safely', () async {
      final service = NoopCrashReportingService(config: const CrashReportingConfig(enabled: true));
      expect(
        () => service.recordError(Exception('Test error'), StackTrace.current),
        returnsNormally,
      );
    });

    test('log works safely', () async {
      final service = NoopCrashReportingService(config: const CrashReportingConfig(enabled: true));
      expect(() => service.log('Test message'), returnsNormally);
    });

    test('setCustomKey and setUserIdentifier work safely', () async {
      final service = NoopCrashReportingService(config: const CrashReportingConfig(enabled: true));
      expect(() => service.setCustomKey('test_key', 'test_value'), returnsNormally);
      expect(() => service.setUserIdentifier('user_123'), returnsNormally);
    });
  });
}
