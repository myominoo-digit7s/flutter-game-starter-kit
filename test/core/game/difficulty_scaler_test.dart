import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/game/difficulty_scaler.dart';

void main() {
  group('DifficultyScaler', () {
    late DifficultyScaler scaler;

    setUp(() {
      scaler = DifficultyScaler(minDifficulty: 1.0, maxDifficulty: 5.0);
    });

    test('starts with minimum difficulty', () {
      expect(scaler.currentDifficulty, 1.0);
    });

    test('increases by score', () {
      scaler.increaseByScore(100, scaleFactor: 0.01);
      expect(scaler.currentDifficulty, 2.0); // 1.0 + (100 * 0.01)
    });

    test('increases by time', () {
      scaler.increaseByTime(const Duration(seconds: 10), scaleFactor: 0.1);
      expect(scaler.currentDifficulty, 2.0); // 1.0 + (10 * 0.1)
    });

    test('does not exceed max difficulty', () {
      scaler.increaseByScore(1000, scaleFactor: 0.01); // would be 11.0
      expect(scaler.currentDifficulty, 5.0);
    });

    test('reset returns to minimum difficulty', () {
      scaler.increaseByScore(100);
      expect(scaler.currentDifficulty, greaterThan(1.0));

      scaler.reset();
      expect(scaler.currentDifficulty, 1.0);
    });
  });
}
