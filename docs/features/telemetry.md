# Telemetry (Analytics & Crash Reporting)

This game starter kit includes a reusable Telemetry module that provides integrated Analytics and Crash Reporting via Firebase. It gracefully degrades to a "Noop" implementation (which just logs to the console) when Firebase is disabled or fails to initialize.

## Features
- **Crash Reporting:** Automatically captures Flutter errors, Platform errors, and manual error logs.
- **Session Tracking:** Measures session lengths automatically using `AnalyticsObserver`.
- **Game Events:** Tracks game start, game over, level complete, and level failed with scores and durations.
- **Ad Events:** Tracks ad impressions, rewarded ad completions, and failures.
- **Economy Events:** Tracks coins earned/spent and skins unlocked.
- **Settings Events:** Tracks when users change sound, music, or language.

## Architecture

The Telemetry module sits in `lib/core/telemetry/`. It orchestrates two independent services:
- `AnalyticsService`
- `CrashReportingService`

These interfaces are implemented by:
- `FirebaseAnalyticsService` & `FirebaseCrashReportingService` (Production)
- `NoopAnalyticsService` & `NoopCrashReportingService` (Development/Fallback)

## Setup
In `lib/app/bootstrap.dart`, the TelemetryService is initialized based on the `TelemetryConfig`:

```dart
final telemetryService = await TelemetryInitializer.initialize(
  const TelemetryConfig(
    firebaseEnabled: true,
    useNoopWhenFirebaseUnavailable: true,
  ),
);
```

If `google-services.json` or `GoogleService-Info.plist` is missing, the initializer catches the initialization error and seamlessly falls back to Noop mode to prevent crashes during development.

## Usage
Access the `AnalyticsService` via dependency injection, or read it from the context if provided by a `RepositoryProvider`:

```dart
final analytics = context.read<TelemetryService>().analytics;

analytics.logGameStart(
  gameId: 'space_shooter',
  gameName: 'Space Shooter',
  levelNumber: 1,
);
```

The `DemoCollectorGame` and `AdManagers` are automatically configured to emit standardized events using `AnalyticsEventName` and `AnalyticsParameter`.

## Compliance
**Important:** Firebase Analytics and Crashlytics collect device identifiers. Make sure you:
1. Update your Privacy Policy to disclose Firebase usage.
2. Complete your Data Safety declaration on Google Play/App Store to reflect the data collected.
3. If your game targets children, ensure you are using family-friendly ads and analytics configurations that do not collect advertising identifiers unprompted.
