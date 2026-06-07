# Flutter + Flame 2D Game Starter Kit

This is Phase 1 of a reusable Flutter + Flame 2D Game Starter Kit. It provides a foundation for future 2D games to reuse core game components, routing, storage, settings, and common screens.

## Tech Stack
- Flutter (latest stable)
- Dart (latest stable)
- flame
- flutter_bloc
- equatable
- go_router
- shared_preferences

## Folder Structure Summary
- `lib/app/`: Application bootstrap, routing, and lifecycle management.
- `lib/core/`: Reusable, generic pieces across the entire app (config, game logic abstractions, settings logic, storage wrappers, themes, utils).
- `lib/features/`: UI screens divided by domain (home, game_shell, settings, shop, leaderboard).
- `lib/games/`: Contains the actual game implementation. In this phase, `demo_placeholder`.

## Phase 1 Includes
- Core Flame Game abstraction (`BaseFlameGame`).
- Essential managers: `ScoreManager`, `LevelManager`, `DifficultyScaler`, `SpawnTimer`.
- UI Placeholders: Home, Game Shell, Settings, Shop, Leaderboard screens.
- Basic Routing via `go_router`.
- Local Storage wrapper via `shared_preferences`.
- Global settings state using `flutter_bloc`.

## Future Phases
Future phases will implement:
- AdMob integration
- AudioService
- Full Localization
- Complete game loop

## How to run
```bash
flutter pub get
flutter run
```

## How to test
```bash
flutter test
```
