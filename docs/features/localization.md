# Localization

The Starter Kit uses `flutter_localizations` and `.arb` files to support multiple languages.

## Supported Languages
- English (`en`)
- Myanmar (`my`)
- Thai (`th`)

## Architecture
- `l10n.yaml` configures the localization generator.
- ARB files are placed in `lib/l10n/`.
- `flutter gen-l10n` generates `AppLocalizations` in `lib/.dart_tool/flutter_gen/gen_l10n`.
- `LocaleCubit` handles language switching and persists the user's choice using `SettingsRepository`.
- `SettingsScreen` includes a dropdown to toggle between languages dynamically.
