import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/analytics/analytics_config.dart';
import 'package:flutter_game_starter_kit/core/analytics/noop_analytics_service.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';
import 'package:flutter_game_starter_kit/core/game/base_flame_game.dart';
import 'package:flutter_game_starter_kit/core/game/game_status.dart';
import 'package:flutter_game_starter_kit/games/demo_collector/demo_collector_game.dart';

class _RecordingAnalyticsService extends NoopAnalyticsService {
  _RecordingAnalyticsService() : super(config: const AnalyticsConfig());

  String? startedGameId;
  String? startedGameName;
  String? endedGameId;
  String? endedGameName;

  @override
  Future<void> logGameStart({
    required String gameId,
    required String gameName,
    int? levelNumber,
  }) async {
    startedGameId = gameId;
    startedGameName = gameName;
  }

  @override
  Future<void> logGameOver({
    required String gameId,
    required String gameName,
    required int score,
    required int bestScore,
    required Duration duration,
    required bool isNewBestScore,
    String? reason,
  }) async {
    endedGameId = gameId;
    endedGameName = gameName;
  }
}

class _ReplacementGame extends BaseFlameGame {
  _ReplacementGame({required super.audioService, super.analyticsService})
    : super(gameId: 'replacement_game', gameName: 'Replacement Game');
}

void main() {
  group('BaseFlameGame identity', () {
    test('uses configured identity for start and end telemetry', () async {
      final analytics = _RecordingAnalyticsService();
      final game = _ReplacementGame(
        audioService: AudioService(soundEffectPlayer: (_) async {}),
        analyticsService: analytics,
      );
      game.overlays.addEntry('HUD', (_, _) => const SizedBox.shrink());
      game.overlays.addEntry('GameOver', (_, _) => const SizedBox.shrink());
      game.onGameResize(Vector2(500, 800));
      await game.onLoad();

      game.startGame();
      game.endGame();

      expect(analytics.startedGameId, 'replacement_game');
      expect(analytics.startedGameName, 'Replacement Game');
      expect(analytics.endedGameId, 'replacement_game');
      expect(analytics.endedGameName, 'Replacement Game');
    });

    test('Demo Collector declares its own identity', () {
      final game = DemoCollectorGame(
        audioService: AudioService(soundEffectPlayer: (_) async {}),
      );

      expect(game.gameId, 'demo_collector');
      expect(game.gameName, 'Demo Collector');
    });

    test('replacement game can restart through the shared lifecycle', () async {
      final analytics = _RecordingAnalyticsService();
      final game = _ReplacementGame(
        audioService: AudioService(soundEffectPlayer: (_) async {}),
        analyticsService: analytics,
      );
      game.overlays.addEntry('HUD', (_, _) => const SizedBox.shrink());
      game.overlays.addEntry('GameOver', (_, _) => const SizedBox.shrink());
      game.overlays.addEntry('Pause', (_, _) => const SizedBox.shrink());
      game.onGameResize(Vector2(500, 800));
      await game.onLoad();

      game.startGame();
      game.scoreManager.addScore(15);
      game.endGame();
      game.restartGame();

      expect(game.status, GameStatus.playing);
      expect(game.scoreManager.currentScore, 0);
      expect(analytics.startedGameId, 'replacement_game');
    });
  });
}
