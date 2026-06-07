import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/game/score_manager.dart';

void main() {
  group('ScoreManager', () {
    late ScoreManager scoreManager;

    setUp(() {
      scoreManager = ScoreManager();
    });

    test('initial score is zero', () {
      expect(scoreManager.currentScore, 0);
      expect(scoreManager.bestScore, 0);
    });

    test('addScore increases score', () {
      scoreManager.addScore(10);
      expect(scoreManager.currentScore, 10);
    });

    test('reset sets score to zero', () {
      scoreManager.addScore(10);
      scoreManager.reset();
      expect(scoreManager.currentScore, 0);
    });

    test('best score updates only when current score is higher', () {
      scoreManager.setInitialBestScore(20);

      scoreManager.addScore(10);
      scoreManager.updateBestScore();
      expect(scoreManager.bestScore, 20); // Not higher

      scoreManager.addScore(20); // Total 30
      scoreManager.updateBestScore();
      expect(scoreManager.bestScore, 30); // Updated
    });
  });
}
