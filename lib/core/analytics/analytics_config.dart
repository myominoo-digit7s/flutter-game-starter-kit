import 'package:equatable/equatable.dart';

class AnalyticsConfig extends Equatable {
  final bool enabled;
  final bool debugLoggingEnabled;
  final bool collectGameEvents;
  final bool collectAdEvents;
  final bool collectEconomyEvents;
  final bool collectSettingsEvents;
  final bool collectRetentionEvents;

  const AnalyticsConfig({
    this.enabled = true,
    this.debugLoggingEnabled = false,
    this.collectGameEvents = true,
    this.collectAdEvents = true,
    this.collectEconomyEvents = true,
    this.collectSettingsEvents = true,
    this.collectRetentionEvents = true,
  });

  AnalyticsConfig copyWith({
    bool? enabled,
    bool? debugLoggingEnabled,
    bool? collectGameEvents,
    bool? collectAdEvents,
    bool? collectEconomyEvents,
    bool? collectSettingsEvents,
    bool? collectRetentionEvents,
  }) {
    return AnalyticsConfig(
      enabled: enabled ?? this.enabled,
      debugLoggingEnabled: debugLoggingEnabled ?? this.debugLoggingEnabled,
      collectGameEvents: collectGameEvents ?? this.collectGameEvents,
      collectAdEvents: collectAdEvents ?? this.collectAdEvents,
      collectEconomyEvents: collectEconomyEvents ?? this.collectEconomyEvents,
      collectSettingsEvents: collectSettingsEvents ?? this.collectSettingsEvents,
      collectRetentionEvents: collectRetentionEvents ?? this.collectRetentionEvents,
    );
  }

  @override
  List<Object?> get props => [
        enabled,
        debugLoggingEnabled,
        collectGameEvents,
        collectAdEvents,
        collectEconomyEvents,
        collectSettingsEvents,
        collectRetentionEvents,
      ];
}
