import 'package:equatable/equatable.dart';

class CrashReportingConfig extends Equatable {
  final bool enabled;
  final bool recordFlutterFatalErrors;
  final bool recordFlutterNonFatalErrors;
  final bool recordPlatformErrors;
  final bool debugLoggingEnabled;

  const CrashReportingConfig({
    this.enabled = true,
    this.recordFlutterFatalErrors = true,
    this.recordFlutterNonFatalErrors = true,
    this.recordPlatformErrors = true,
    this.debugLoggingEnabled = false,
  });

  CrashReportingConfig copyWith({
    bool? enabled,
    bool? recordFlutterFatalErrors,
    bool? recordFlutterNonFatalErrors,
    bool? recordPlatformErrors,
    bool? debugLoggingEnabled,
  }) {
    return CrashReportingConfig(
      enabled: enabled ?? this.enabled,
      recordFlutterFatalErrors: recordFlutterFatalErrors ?? this.recordFlutterFatalErrors,
      recordFlutterNonFatalErrors: recordFlutterNonFatalErrors ?? this.recordFlutterNonFatalErrors,
      recordPlatformErrors: recordPlatformErrors ?? this.recordPlatformErrors,
      debugLoggingEnabled: debugLoggingEnabled ?? this.debugLoggingEnabled,
    );
  }

  @override
  List<Object?> get props => [
        enabled,
        recordFlutterFatalErrors,
        recordFlutterNonFatalErrors,
        recordPlatformErrors,
        debugLoggingEnabled,
      ];
}
