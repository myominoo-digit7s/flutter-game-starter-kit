class DifficultyScaler {
  final double minDifficulty;
  final double maxDifficulty;

  double _currentDifficulty;

  DifficultyScaler({this.minDifficulty = 1.0, this.maxDifficulty = 5.0})
    : _currentDifficulty = minDifficulty;

  double get currentDifficulty => _currentDifficulty;

  void increaseByScore(int score, {double scaleFactor = 0.01}) {
    if (score > 0) {
      _currentDifficulty = minDifficulty + (score * scaleFactor);
      if (_currentDifficulty > maxDifficulty) {
        _currentDifficulty = maxDifficulty;
      }
    }
  }

  void increaseByTime(Duration duration, {double scaleFactor = 0.05}) {
    if (duration.inSeconds > 0) {
      _currentDifficulty = minDifficulty + (duration.inSeconds * scaleFactor);
      if (_currentDifficulty > maxDifficulty) {
        _currentDifficulty = maxDifficulty;
      }
    }
  }

  void reset() {
    _currentDifficulty = minDifficulty;
  }
}
