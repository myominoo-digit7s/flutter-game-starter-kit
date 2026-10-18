import 'dart:async';

import 'package:flutter/foundation.dart';

typedef AdRetryTimerFactory =
    Timer Function(Duration delay, VoidCallback callback);

/// Schedules a small, bounded retry only for network load failures.
class AdLoadRetry {
  static const int maxAttempts = 3;
  static const int maxRetries = maxAttempts - 1;
  static const int networkErrorCode = 2;

  final AdRetryTimerFactory _createTimer;
  Timer? _timer;
  int _retryCount = 0;
  bool _isDisposed = false;

  AdLoadRetry({AdRetryTimerFactory? createTimer})
    : _createTimer = createTimer ?? Timer.new;

  void onLoaded() {
    _retryCount = 0;
    _timer?.cancel();
    _timer = null;
  }

  void onFailed(int errorCode, VoidCallback retry) {
    if (_isDisposed ||
        _timer?.isActive == true ||
        errorCode != networkErrorCode ||
        _retryCount >= maxRetries) {
      return;
    }

    _retryCount++;
    final delay = Duration(seconds: 1 << _retryCount);
    _timer = _createTimer(delay, () {
      _timer = null;
      if (!_isDisposed) retry();
    });
  }

  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    _timer = null;
  }
}
