class LevelManager {
  final int _scoreThresholdPerLevel;
  int _currentLevel = 1;

  LevelManager({int scoreThresholdPerLevel = 100})
    : _scoreThresholdPerLevel = scoreThresholdPerLevel;

  int get currentLevel => _currentLevel;

  void updateLevelByScore(int score) {
    if (score >= 0) {
      _currentLevel = (score ~/ _scoreThresholdPerLevel) + 1;
    }
  }

  void reset() {
    _currentLevel = 1;
  }
}
