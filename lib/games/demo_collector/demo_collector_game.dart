import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../core/game/base_flame_game.dart';
import '../../core/game/difficulty_scaler.dart';
import '../../core/game/game_status.dart';
import 'components/collectible_component.dart';
import 'components/obstacle_component.dart';
import 'components/player_component.dart';
import 'components/spawner_component.dart';

class DemoCollectorGame extends BaseFlameGame
    with HasCollisionDetection, PanDetector {
  late PlayerComponent _player;
  late SpawnerComponent _spawner;
  late TextComponent _scoreText;

  final DifficultyScaler difficultyScaler = DifficultyScaler();

  DemoCollectorGame({
    required super.audioService,
    super.analyticsService,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _setupGame();
  }

  void _setupGame() {
    _player = PlayerComponent()..position = Vector2(size.x / 2, size.y - 100);
    _spawner = SpawnerComponent();

    _scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(16, 16),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    add(_player);
    add(_spawner);
    add(_scoreText);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (status == GameStatus.playing) {
      difficultyScaler.increaseByScore(
        scoreManager.currentScore,
        scaleFactor: 0.02,
      );
      _scoreText.text = 'Score: ${scoreManager.currentScore}';
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (status == GameStatus.playing) {
      _player.move(info.delta.global.x, size.x);
    }
  }

  void onCollectibleCaught() {
    scoreManager.addScore(10);
    audioService.playSfx('collect.wav'); // Placeholder
  }

  void onObstacleHit() {
    audioService.playSfx('crash.wav'); // Placeholder
    endGame();
  }

  @override
  void restartGame() {
    super.restartGame();

    // Clear all existing entities
    children.whereType<CollectibleComponent>().forEach(
      (c) => c.removeFromParent(),
    );
    children.whereType<ObstacleComponent>().forEach(
      (c) => c.removeFromParent(),
    );

    difficultyScaler.reset();
    _player.position = Vector2(size.x / 2, size.y - 100);
  }
}
