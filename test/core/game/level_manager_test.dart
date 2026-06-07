import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/game/level_manager.dart';

void main() {
  group('LevelManager', () {
    late LevelManager levelManager;

    setUp(() {
      levelManager = LevelManager(scoreThresholdPerLevel: 100);
    });

    test('initial level is one', () {
      expect(levelManager.currentLevel, 1);
    });

    test('level increases after score threshold', () {
      levelManager.updateLevelByScore(50);
      expect(levelManager.currentLevel, 1);

      levelManager.updateLevelByScore(100);
      expect(levelManager.currentLevel, 2);

      levelManager.updateLevelByScore(250);
      expect(levelManager.currentLevel, 3);
    });

    test('reset returns level to one', () {
      levelManager.updateLevelByScore(150);
      expect(levelManager.currentLevel, 2);

      levelManager.reset();
      expect(levelManager.currentLevel, 1);
    });
  });
}
