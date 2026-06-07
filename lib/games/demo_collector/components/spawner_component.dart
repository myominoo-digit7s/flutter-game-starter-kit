import 'dart:math';
import 'package:flame/components.dart';

import '../../../core/game/spawn_timer.dart';
import '../demo_collector_game.dart';
import 'collectible_component.dart';
import 'obstacle_component.dart';

class SpawnerComponent extends Component
    with HasGameReference<DemoCollectorGame> {
  late final SpawnTimer _timer;
  final Random _random = Random();

  SpawnerComponent() {
    _timer = SpawnTimer(interval: 1.5);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Scale spawn rate based on difficulty
    final currentDifficulty = game.difficultyScaler.currentDifficulty;
    _timer.update(dt * currentDifficulty);

    if (_timer.shouldSpawn) {
      _spawnEntity();
    }
  }

  void _spawnEntity() {
    final screenWidth = game.size.x;
    if (screenWidth <= 0) return;

    final xPos =
        _random.nextDouble() * (screenWidth - 40) + 20; // Keep away from edges
    final speed = 150.0 * game.difficultyScaler.currentDifficulty;

    final isObstacle = _random.nextDouble() < 0.3; // 30% chance for an obstacle

    if (isObstacle) {
      game.add(ObstacleComponent(speed: speed, position: Vector2(xPos, -30)));
    } else {
      game.add(
        CollectibleComponent(speed: speed, position: Vector2(xPos, -30)),
      );
    }
  }
}
