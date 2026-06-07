import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';
import 'package:flutter_game_starter_kit/core/game/game_status.dart';
import 'package:flutter_game_starter_kit/games/demo_collector/demo_collector_game.dart';
import 'package:flutter_game_starter_kit/games/demo_collector/components/player_component.dart';

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
  group('DemoCollectorGame', () {
    test('Game initializes correctly', () async {
      final game = DemoCollectorGame(audioService: MockAudioService());
      game.onGameResize(Vector2(500, 800));
      await game.onLoad();

      expect(game.children.whereType<PlayerComponent>().length, 1);
    });

    test('Score updates when collectible caught', () async {
      final game = DemoCollectorGame(audioService: MockAudioService());
      game.onGameResize(Vector2(500, 800));
      await game.onLoad();

      expect(game.scoreManager.currentScore, 0);

      game.onCollectibleCaught();

      expect(game.scoreManager.currentScore, 10);
    });

    test('Game over triggers when obstacle hit', () async {
      final game = DemoCollectorGame(audioService: MockAudioService());

      // Register dummy overlay builders so overlays.add() doesn't throw
      game.overlays.addEntry('HUD', (context, game) => const SizedBox.shrink());
      game.overlays.addEntry('GameOver', (context, game) => const SizedBox.shrink());

      game.onGameResize(Vector2(500, 800));
      await game.onLoad();

      game.startGame();
      expect(game.status, GameStatus.playing);

      game.onObstacleHit();

      expect(game.status, GameStatus.gameOver);
    });
  });
}
