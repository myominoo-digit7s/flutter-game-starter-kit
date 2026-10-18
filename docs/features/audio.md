# AudioService

`AudioService` provides a central wrapper for handling background music (BGM) and sound effects (SFX) using `flame_audio`.

## Safe Placeholders
Currently, audio files might not be provided. `AudioService` catches any exceptions when trying to load or play audio so that the game does not crash.

## Integration
- `SettingsCubit` calls `AudioService.updateSettings()` to keep BGM/SFX toggles synced.
- `BaseFlameGame` receives `AudioService` in its constructor, allowing gameplay logic to trigger sounds directly via `game.audioService.playSfx('explosion.wav')`.

## Prefetch placeholder

`AudioService.prefetch()` is currently a no-op placeholder: it does not load or
cache audio assets. Add and register licensed files under `assets/audio/` as
described in the [new game guide](../create-new-game-guide.md). Missing audio
files are handled by the service's safe playback boundary; do not rely on
prefetching to make them available.
