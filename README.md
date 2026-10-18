# Flutter + Flame Game Starter Kit

A Flutter and Flame 2D game starter template with a Demo Collector example, shared settings, localization, audio, storage, and optional AdMob and Firebase integrations. Release readiness depends on configuring and verifying the app for each game and target platform; this repository does not ship production signing credentials or Firebase configuration.

---

## 🚀 Getting Started

### Prerequisites
- Flutter 3.41.2 stable is the CI and locally validated baseline (Dart 3.11.0).
  `pubspec.yaml` requires Dart `^3.11.0`; other compatible Flutter versions
  are not covered by the current CI run.
- IDE of your choice (VS Code, Android Studio, IntelliJ)

### How to Run
To run the demo game locally:
```bash
flutter pub get
flutter run
```

AdMob and Firebase telemetry are disabled by default, so the demo runs without
AdMob or Firebase project configuration. To exercise Google test ads, run
`flutter run --dart-define=ENABLE_ADS=true`. To enable Firebase analytics and
crash reporting, configure the native Firebase projects first, then run with
`--dart-define=ENABLE_TELEMETRY=true`.

### How to Test

See the [testing guide](docs/features/testing.md) for the validation commands
used by CI and the advisory repository-wide formatting policy.

### Contribution and Release Preparation

See [Contributing](CONTRIBUTING.md) for the pull request checks and
[Release Preparation](docs/release-preparation.md) for Android signing, iOS
prerequisites, versioning, and store verification. CI has no production
credentials and does not build signed release artifacts or publish apps.

The committed `pubspec.lock` keeps application dependencies reproducible;
include intentional lockfile changes with dependency changes. The CI Flutter
version is pinned at 3.41.2 and should be updated only after validation.

### Android Release Signing

Android and iOS signing, platform identifiers, and release checks are covered
in the canonical [release preparation guide](docs/release-preparation.md). The
starter contains no production signing credentials.

---

## 🎮 Create a New Game

Follow the [new game guide](docs/create-new-game-guide.md) to replace Demo
Collector at the existing router factory, configure game identity and app
branding, add assets, choose optional integrations, and build a debug APK.

## Integrations and localization

AdMob, Firebase telemetry, audio, localization, and storage are described in
the [feature guides](docs/README.md). AdMob and Firebase are opt-in at runtime;
compliance checklists are developer placeholders and do not establish legal
or store-policy compliance.

## 📚 Documentation

Browse the [documentation index](docs/README.md) for the architecture, game
creation, feature, testing, release, and compliance guides.

## License

This project is open-sourced under the MIT License.
