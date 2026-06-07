# Settings

The `core/settings` folder provides global state management for user preferences.

- **SettingsState**: An `Equatable` class holding `soundEnabled`, `musicEnabled`, `vibrationEnabled`, and `selectedLocale`.
- **SettingsRepository**: Reads and writes these settings to the `LocalStorageService`.
- **SettingsCubit**: Exposes the settings to the Flutter UI layer, offering toggle methods that automatically persist changes.
