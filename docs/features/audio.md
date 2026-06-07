# AudioService

`AudioService` provides a central wrapper for handling background music (BGM) and sound effects (SFX) using `flame_audio`.

## Safe Placeholders
Currently, audio files might not be provided. `AudioService` catches any exceptions when trying to load or play audio so that the game does not crash.

## Integration
- `SettingsCubit` calls `AudioService.updateSettings()` to keep BGM/SFX toggles synced.
- `BaseFlameGame` receives `AudioService` in its constructor, allowing gameplay logic to trigger sounds directly via `game.audioService.playSfx('explosion.wav')`.

## Pre-fetching
The `prefetch()` method can be called during initial loading to cache audio assets before the game starts.
