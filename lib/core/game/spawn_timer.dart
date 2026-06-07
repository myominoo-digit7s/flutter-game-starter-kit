class SpawnTimer {
  final double interval;
  double _elapsed = 0.0;
  bool _isPaused = false;

  SpawnTimer({required this.interval});

  double get elapsed => _elapsed;
  bool get isPaused => _isPaused;

  void update(double dt) {
    if (!_isPaused) {
      _elapsed += dt;
    }
  }

  bool get shouldSpawn {
    if (_elapsed >= interval) {
      _elapsed = 0.0; // Automatically reset after a spawn trigger
      return true;
    }
    return false;
  }

  void reset() {
    _elapsed = 0.0;
  }

  void pause() {
    _isPaused = true;
  }

  void resume() {
    _isPaused = false;
  }
}
