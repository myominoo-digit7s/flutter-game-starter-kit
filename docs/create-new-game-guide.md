# How to Create a New Game

The Starter Kit includes `DemoCollectorGame` as an example of how everything fits together. To build your own game and replace the demo, follow these steps:

## 1. Create your Game Class
Create a new directory inside `lib/games/` (e.g., `lib/games/my_awesome_game/`).
Create your main game class and extend `BaseFlameGame`.

```dart
import '../../core/game/base_flame_game.dart';

class MyAwesomeGame extends BaseFlameGame {
  MyAwesomeGame({required super.audioService});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Add your components here
  }

  // Handle game logic
}
```

## 2. Connect Your Game to the UI Shell
Open `lib/features/game_shell/game_shell_screen.dart`.
Replace `DemoCollectorGame` with your `MyAwesomeGame`.

```dart
    if (!_isInitialized) {
      final audioService = context.read<AudioService>();
      final interstitialAdManager = context.read<InterstitialAdManager>();
      
      _game = MyAwesomeGame(audioService: audioService);
      // ...
    }
```

Update the overlay maps in `GameWidget` to cast `game` to your new class.

## 3. Utilize Core Managers
Inside your game class, you have access to:
- `scoreManager`: Call `scoreManager.addScore(10)` and read `scoreManager.currentScore`.
- `difficultyScaler`: Increase difficulty over time or score.
- `audioService`: Call `audioService.playSfx('sound.wav')`.
- `status`: Check if the game is `GameStatus.playing` before moving components.

## 4. End the Game
When the player loses, simply call `setGameOver()`. `BaseFlameGame` will automatically handle pausing the engine and triggering the Game Over overlay!
