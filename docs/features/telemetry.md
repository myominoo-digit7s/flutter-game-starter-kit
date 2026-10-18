# Telemetry (Analytics and Crash Reporting)

Firebase analytics and crash reporting are optional and disabled by default.
`TelemetryInitializer` returns the existing no-op analytics and crash-reporting
services when Firebase is disabled. Game and settings code can continue calling
the shared analytics API without requiring Firebase.

## Enable Firebase

1. Create/register the game app in Firebase for each platform you ship.
2. Add the platform configuration using the official FlutterFire/Firebase
   setup for this project. The repository does not include a Firebase project
   configuration.
3. Run/build with `--dart-define=ENABLE_TELEMETRY=true`.

For example:

```bash
flutter run --dart-define=ENABLE_TELEMETRY=true
```

If Firebase initialization fails and the existing fallback is enabled, the
initializer logs a development diagnostic and returns no-op services. Do not
mistake that fallback for successful telemetry delivery.

Analytics and crash collection settings are configured in
`lib/core/analytics/analytics_config.dart` and
`lib/core/crash_reporting/crash_reporting_config.dart`. The app currently
initializes Firebase as a single optional telemetry integration; it does not
provide a general provider registry.

Firebase analytics and Crashlytics may collect device or diagnostic data.
Review the actual SDK behavior, audience, consent obligations, privacy policy,
and store data declarations for your game before enabling them in a release.
The compliance screens are starter checklists, not legal advice or a compliance
guarantee.
