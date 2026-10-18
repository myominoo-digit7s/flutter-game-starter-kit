import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';
import 'package:flutter_game_starter_kit/core/game/game_status.dart';
import 'package:flutter_game_starter_kit/games/demo_collector/demo_collector_game.dart';
import 'package:flutter_game_starter_kit/games/demo_collector/components/collectible_component.dart';
import 'package:flutter_game_starter_kit/games/demo_collector/components/obstacle_component.dart';
import 'package:flutter_game_starter_kit/games/demo_collector/components/spawner_component.dart';

class MockAudioService implements AudioService {
  @override
  void playSfx(String file) {}
  @override
  void playBgm(String file) {}
  @override
  void stopBgm() {}
  @override
  void pauseBgm() {}
  @override
  void resumeBgm() {}
  @override
  Future<void> prefetch() async {}
  @override
  void updateSettings({
    required bool soundEnabled,
    required bool musicEnabled,
  }) {}
}

void main() {
  group('SpawnerComponent', () {
    test('Spawns entities periodically', () async {
      final game = DemoCollectorGame(audioService: MockAudioService());
      game.overlays.addEntry('HUD', (_, _) => const SizedBox.shrink());
      game.overlays.addEntry('GameOver', (_, _) => const SizedBox.shrink());

      // Fake size for testing since it's not attached to a widget
      game.onGameResize(Vector2(500, 800));

      await game.onLoad();

      // Spawner interval is 1.5
      expect(
        game.children.whereType<CollectibleComponent>().length +
            game.children.whereType<ObstacleComponent>().length,
        0,
      );

      final spawner = game.children.whereType<SpawnerComponent>().first;
      game.startGame();
      spawner.update(2.0);

      // Should have spawned a new component (Collectible or Obstacle)
      game.update(0); // process lifecycle
      expect(
        game.children.whereType<CollectibleComponent>().length +
            game.children.whereType<ObstacleComponent>().length,
        greaterThan(0),
      );

      game.endGame();
      game.restartGame();
      spawner.update(0.6);
      game.update(0);
      expect(
        game.children.whereType<CollectibleComponent>().length +
            game.children.whereType<ObstacleComponent>().length,
        0,
      );
    });

    test('restart clears the previous run spawn interval', () async {
      final game = DemoCollectorGame(audioService: MockAudioService());
      game.overlays.addEntry('HUD', (_, _) => const SizedBox.shrink());
      game.overlays.addEntry('GameOver', (_, _) => const SizedBox.shrink());
      game.onGameResize(Vector2(500, 800));
      await game.onLoad();

      game.startGame();
      final spawner = game.children.whereType<SpawnerComponent>().single;
      spawner.update(1.0);
      game.endGame();
      game.restartGame();

      expect(game.status, GameStatus.playing);
      spawner.update(0.6);
      game.update(0);
      expect(
        game.children.whereType<CollectibleComponent>().length +
            game.children.whereType<ObstacleComponent>().length,
        0,
      );

      spawner.update(1.5);
      game.update(0);
      expect(
        game.children.whereType<CollectibleComponent>().length +
            game.children.whereType<ObstacleComponent>().length,
        greaterThan(0),
      );
    });
  });
}
