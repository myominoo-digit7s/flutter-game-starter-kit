import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import '../analytics/analytics_service.dart';
import '../audio/audio_service.dart';
import 'game_result.dart';
import 'game_status.dart';
import 'score_manager.dart';

abstract class BaseFlameGame extends FlameGame {
  final AudioService audioService;
  final AnalyticsService? analyticsService;

  GameStatus _status = GameStatus.initial;
  final ScoreManager scoreManager = ScoreManager();

  BaseFlameGame({
    required this.audioService,
    this.analyticsService,
  });

  GameStatus get status => _status;

  // Callback when the game ends
  ValueChanged<GameResult>? onGameResult;

  final DateTime _startTime = DateTime.now();
  Duration _gameDuration = Duration.zero;

  void startGame() {
    _status = GameStatus.playing;
    resumeEngine();
    overlays.remove('GameOver');
    overlays.remove('Pause');
    overlays.add('HUD');
    
    analyticsService?.logGameStart(
      gameId: 'demo_collector',
      gameName: 'Demo Collector',
      levelNumber: 1,
    );
  }

  void pauseGame() {
    if (_status == GameStatus.playing) {
      _status = GameStatus.paused;
      pauseEngine();
      overlays.add('Pause');
    }
  }

  void resumeGame() {
    if (_status == GameStatus.paused) {
      _status = GameStatus.playing;
      resumeEngine();
      overlays.remove('Pause');
    }
  }

  void endGame() {
    if (_status != GameStatus.gameOver) {
      _status = GameStatus.gameOver;
      pauseEngine();

      final isNewBestScore = scoreManager.isNewBestScore;
      scoreManager.updateBestScore();
      _gameDuration = DateTime.now().difference(_startTime);

      final result = GameResult(
        score: scoreManager.currentScore,
        bestScore: scoreManager.bestScore,
        coinsEarned: scoreManager.currentScore ~/ 10, // simple calc
        duration: _gameDuration,
        isNewBestScore: isNewBestScore,
      );

      if (onGameResult != null) {
        onGameResult!(result);
      }

      analyticsService?.logGameOver(
        gameId: 'demo_collector',
        gameName: 'Demo Collector',
        score: result.score,
        bestScore: result.bestScore,
        duration: result.duration,
        isNewBestScore: result.isNewBestScore,
      );

      overlays.add('GameOver');
    }
  }

  void restartGame() {
    resetGame();
    startGame();
  }

  void resetGame() {
    _status = GameStatus.ready;
    scoreManager.reset();
    _gameDuration = Duration.zero;
  }
}
