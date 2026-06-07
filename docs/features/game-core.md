# Game Core

The `core/game` directory provides generic utilities for any Flame game.

- **BaseFlameGame**: Extends `FlameGame`. It manages the `GameStatus`, starts/pauses/resumes the game engine, and handles `overlays` integration.
- **GameStatus**: Enum defining the lifecycle states (`initial`, `loading`, `ready`, `playing`, `paused`, `gameOver`).
- **GameResult**: A data class using `equatable` to return the final game stats (score, best score, coins, duration).
- **ScoreManager**: Tracks `currentScore` and `bestScore`.
- **LevelManager**: Handles level progression based on a `scoreThresholdPerLevel`.
- **DifficultyScaler**: Increases a difficulty multiplier over time or by score. Capped at `maxDifficulty`.
- **SpawnTimer**: A utility component to manage timed spawning, taking into account game pauses.

## Demo Collector Game

The Starter Kit includes a functional "Demo Collector" game built using these core utilities:
- **`DemoCollectorGame`** extends `BaseFlameGame` and adds collision detection and drag gestures.
- It dynamically updates the score utilizing `ScoreManager`.
- It spawns Collectibles and Obstacles using `SpawnTimer` and scales their speed using the `DifficultyScaler`.
