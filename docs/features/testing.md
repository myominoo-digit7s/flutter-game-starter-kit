# Testing

Run validation from the project root. The commands below match the blocking
checks in `.github/workflows/ci.yml`; a locally configured workflow is not
evidence of a hosted GitHub Actions result.

## Structure
The `test/` directory mirrors the structure of `lib/`.
- **Unit Tests**: Test Dart classes like `ScoreManager`, `DifficultyScaler`, `LevelManager`, `SpawnTimer`, and `SettingsCubit`. We use `mocktail` for any mocking needs and `SharedPreferences.setMockInitialValues` for storage testing.
- **Widget Tests**: Test Flutter UI components like `HomeScreen` and `SettingsScreen`.

## Validation commands

```bash
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter build apk --debug
```

The workflow also runs a whole-repository Dart formatting check as advisory
while the existing formatting baseline is being addressed. Format changed Dart
files with `dart format <files>`; do not treat the advisory repository-wide
check as evidence that hosted CI has passed.
