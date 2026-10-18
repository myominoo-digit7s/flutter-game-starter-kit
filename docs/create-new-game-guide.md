# How to Create a New Game

The Starter Kit includes `DemoCollectorGame` as an example of how everything fits together. To build your own game and replace the demo, follow these steps:

## 1. Create your Game Class
Create a new directory inside `lib/games/` (e.g., `lib/games/my_awesome_game/`).
Create your main game class and extend `BaseFlameGame`.

```dart
import '../../core/game/base_flame_game.dart';

class MyAwesomeGame extends BaseFlameGame {
  MyAwesomeGame({required super.audioService})
      : super(gameId: 'my_awesome_game', gameName: 'My Awesome Game');

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Add your components here
  }

  // Handle game logic
}
```

## 2. Connect Your Game to the UI Shell
Open `lib/app/router/app_router.dart`.
Replace the `DemoCollectorGame` returned by the `/game` route's `gameFactory`.

```dart
gameFactory: (audioService, analyticsService) => MyAwesomeGame(
  audioService: audioService,
  analyticsService: analyticsService,
),
```

The shared shell's HUD, pause, and game-over overlays use `BaseFlameGame`, so
they work with the replacement game without changing their types. Add a
game-specific overlay only when your game needs behavior beyond those shared
overlays.

## 3. Utilize Core Managers
Inside your game class, you have access to:
- `scoreManager`: Call `scoreManager.addScore(10)` and read `scoreManager.currentScore`.
- `difficultyScaler`: Increase difficulty over time or score.
- `audioService`: Call `audioService.playSfx('sound.wav')`.
- `status`: Check if the game is `GameStatus.playing` before moving components.

## 4. End the Game
When the player loses, simply call `setGameOver()`. `BaseFlameGame` will automatically handle pausing the engine and triggering the Game Over overlay!
