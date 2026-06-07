# Testing

The starter kit embraces a test-driven approach for core logic.

## Structure
The `test/` directory mirrors the structure of `lib/`.
- **Unit Tests**: Test Dart classes like `ScoreManager`, `DifficultyScaler`, `LevelManager`, `SpawnTimer`, and `SettingsCubit`. We use `mocktail` for any mocking needs and `SharedPreferences.setMockInitialValues` for storage testing.
- **Widget Tests**: Test Flutter UI components like `HomeScreen` and `SettingsScreen`.

## Phase 1 Test Coverage
Phase 1 ensures the stability of:
- All generic game managers.
- Local storage abstractions.
- Settings state management.
- Basic placeholder screens showing the expected widgets.

## How to run tests
From the project root:
```bash
flutter test
```
