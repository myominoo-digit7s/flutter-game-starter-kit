class EnvironmentConfig {
  static const bool isDevelopment = !bool.fromEnvironment('dart.vm.product');

  /// Optional Google Mobile Ads integration. Disabled unless explicitly enabled.
  static const bool adsEnabled = bool.fromEnvironment(
    'ENABLE_ADS',
    defaultValue: false,
  );

  /// Optional Firebase analytics and crash reporting integration.
  static const bool telemetryEnabled = bool.fromEnvironment(
    'ENABLE_TELEMETRY',
    defaultValue: false,
  );
}
