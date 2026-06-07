import 'package:equatable/equatable.dart';

class AnalyticsEvent extends Equatable {
  final String name;
  final Map<String, Object?> parameters;
  final DateTime timestamp;

  AnalyticsEvent({
    required this.name,
    this.parameters = const {},
    DateTime? timestamp,
  })  : assert(name.isNotEmpty, 'Event name cannot be empty'),
        timestamp = timestamp ?? DateTime.now();

  Map<String, Object> get sanitizedParameters {
    final sanitized = <String, Object>{};
    parameters.forEach((key, value) {
      if (value != null) {
        sanitized[key] = value;
      }
    });
    return sanitized;
  }

  AnalyticsEvent copyWith({
    String? name,
    Map<String, Object?>? parameters,
    DateTime? timestamp,
  }) {
    return AnalyticsEvent(
      name: name ?? this.name,
      parameters: parameters ?? this.parameters,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [name, parameters, timestamp];
}
