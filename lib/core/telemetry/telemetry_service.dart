import '../analytics/analytics_service.dart';
import '../crash_reporting/crash_reporting_service.dart';

class TelemetryService {
  final AnalyticsService analytics;
  final CrashReportingService crashReporting;

  TelemetryService({
    required this.analytics,
    required this.crashReporting,
  });

  Future<void> initialize() async {
    await crashReporting.initialize();
    await analytics.initialize();
  }
}
