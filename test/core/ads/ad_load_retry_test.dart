import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/ads/ad_load_retry.dart';

class _ScheduledTimer implements Timer {
  final Duration delay;
  final VoidCallback callback;
  bool _isActive = true;

  _ScheduledTimer(this.delay, this.callback);

  void fire() {
    if (!_isActive) return;
    _isActive = false;
    callback();
  }

  @override
  void cancel() => _isActive = false;

  @override
  bool get isActive => _isActive;

  @override
  int get tick => 0;
}

void main() {
  group('AdLoadRetry', () {
    late List<_ScheduledTimer> timers;
    late AdLoadRetry retry;

    setUp(() {
      timers = [];
      retry = AdLoadRetry(
        createTimer: (delay, callback) {
          final timer = _ScheduledTimer(delay, callback);
          timers.add(timer);
          return timer;
        },
      );
    });

    test('retries transient network failures at most twice', () {
      var attempts = 1;
      retry.onFailed(AdLoadRetry.networkErrorCode, () => attempts++);
      expect(timers.single.delay, const Duration(seconds: 2));
      timers[0].fire();

      retry.onFailed(AdLoadRetry.networkErrorCode, () => attempts++);
      expect(timers[1].delay, const Duration(seconds: 4));
      timers[1].fire();

      retry.onFailed(AdLoadRetry.networkErrorCode, () => attempts++);

      expect(attempts, AdLoadRetry.maxAttempts);
      expect(timers, hasLength(2));
    });

    test('does not retry non-network failures', () {
      retry.onFailed(3, () {});

      expect(timers, isEmpty);
    });

    test('cancels a scheduled retry when disposed', () {
      var retried = false;
      retry.onFailed(AdLoadRetry.networkErrorCode, () => retried = true);

      retry.dispose();
      timers.single.fire();

      expect(timers.single.isActive, isFalse);
      expect(retried, isFalse);
    });
  });
}
