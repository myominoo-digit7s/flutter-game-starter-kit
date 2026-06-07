class ScoreManager {
  int _currentScore = 0;
  int _bestScore = 0;

  int get currentScore => _currentScore;
  int get bestScore => _bestScore;

  void addScore(int points) {
    if (points > 0) {
      _currentScore += points;
    }
  }

  void reset() {
    _currentScore = 0;
  }

  void updateBestScore() {
    if (_currentScore > _bestScore) {
      _bestScore = _currentScore;
    }
  }

  bool get isNewBestScore => _currentScore > _bestScore;

  // Added for test initialization if needed
  void setInitialBestScore(int score) {
    _bestScore = score;
  }
}
