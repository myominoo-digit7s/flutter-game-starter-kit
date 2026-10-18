# Localization

The Starter Kit uses `flutter_localizations` and `.arb` files to support multiple languages.

## Supported Languages
- English (`en`)
- Myanmar (`my`)
- Thai (`th`)

## Architecture
- `l10n.yaml` configures the localization generator.
- ARB files are placed in `lib/l10n/`.
- `l10n.yaml` sets `output-dir: lib/l10n` and
  `output-localization-file: app_localizations.dart`. Run
  `flutter gen-l10n` to generate `lib/l10n/app_localizations.dart` and its
  locale-specific part files there.
- `LocaleCubit` handles language switching and persists the user's choice using `SettingsRepository`.
- `SettingsScreen` includes a dropdown to toggle between languages dynamically.
