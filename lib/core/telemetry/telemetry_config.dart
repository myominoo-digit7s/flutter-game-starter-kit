import 'package:equatable/equatable.dart';

import '../analytics/analytics_config.dart';
import '../crash_reporting/crash_reporting_config.dart';

class TelemetryConfig extends Equatable {
  final AnalyticsConfig analyticsConfig;
  final CrashReportingConfig crashReportingConfig;
  final bool firebaseEnabled;
  final bool useNoopWhenFirebaseUnavailable;

  const TelemetryConfig({
    this.analyticsConfig = const AnalyticsConfig(),
    this.crashReportingConfig = const CrashReportingConfig(),
    this.firebaseEnabled = true,
    this.useNoopWhenFirebaseUnavailable = true,
  });

  TelemetryConfig copyWith({
    AnalyticsConfig? analyticsConfig,
    CrashReportingConfig? crashReportingConfig,
    bool? firebaseEnabled,
    bool? useNoopWhenFirebaseUnavailable,
  }) {
    return TelemetryConfig(
      analyticsConfig: analyticsConfig ?? this.analyticsConfig,
      crashReportingConfig: crashReportingConfig ?? this.crashReportingConfig,
      firebaseEnabled: firebaseEnabled ?? this.firebaseEnabled,
      useNoopWhenFirebaseUnavailable: useNoopWhenFirebaseUnavailable ?? this.useNoopWhenFirebaseUnavailable,
    );
  }

  @override
  List<Object?> get props => [
        analyticsConfig,
        crashReportingConfig,
        firebaseEnabled,
        useNoopWhenFirebaseUnavailable,
      ];
}
