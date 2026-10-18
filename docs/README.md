# Project Documentation

This is a single-game Flutter + Flame starter template. Demo Collector is the
example game selected at the app router's game factory. AdMob and Firebase
telemetry are optional and disabled by default.

## Start here

- [Create a new game](create-new-game-guide.md) — replace the demo, configure
  game identity and app branding, register assets, select integrations, and
  build a debug APK.
- [Architecture](architecture.md) — shared modules and project boundaries.
- [Game core](features/game-core.md) — shared Flame base and game utilities.
- [Routing](features/routing.md) — app routes and the game shell.
- [Settings](features/settings.md) — settings state and controls.
- [Storage](features/storage.md) — persistence boundaries and stored values.
- [Localization](features/localization.md) — ARB files and runtime language
  selection.
- [Audio](features/audio.md) — optional Flame audio and settings integration.
- [AdMob](features/ads.md) — opt-in SDK configuration and ad unit IDs.
- [Telemetry](features/telemetry.md) — optional Firebase and no-op behavior.
- [Testing](features/testing.md) — local validation commands and test layout.
- [Compliance checklist](compliance/README.md) — developer checklist
  placeholders, not legal advice or a compliance guarantee.

The root [README](../README.md) covers project setup and quick start.
Production signing, native iOS builds, and store submissions must be
configured and verified for each game. See the
[release preparation guide](release-preparation.md) for the validated Flutter
baseline, Android/iOS prerequisites, signing, versioning, and store checks.
