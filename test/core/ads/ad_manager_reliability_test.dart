import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_game_starter_kit/core/ads/ad_load_retry.dart';
import 'package:flutter_game_starter_kit/core/ads/interstitial_ad_manager.dart';
import 'package:flutter_game_starter_kit/core/ads/rewarded_ad_manager.dart';

class _FakeLoadAdError extends Fake implements LoadAdError {
  @override
  final int code;

  _FakeLoadAdError(this.code);

  @override
  String get domain => 'test';

  @override
  String get message => 'test load error';

  @override
  ResponseInfo? get responseInfo => null;
}

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

class _FakeRewardedAd extends Fake implements RewardedAd {
  FullScreenContentCallback<RewardedAd>? callback;
  OnUserEarnedRewardCallback? earnedReward;
  int disposeCount = 0;

  @override
  set fullScreenContentCallback(FullScreenContentCallback<RewardedAd>? value) {
    callback = value;
  }

  @override
  Future<void> show({
    required OnUserEarnedRewardCallback onUserEarnedReward,
  }) async {
    earnedReward = onUserEarnedReward;
  }

  @override
  Future<void> dispose() async {
    disposeCount++;
  }
}

class _FakeInterstitialAd extends Fake implements InterstitialAd {
  int disposeCount = 0;

  @override
  Future<void> dispose() async {
    disposeCount++;
  }
}

class _FakeTimers {
  final List<_ScheduledTimer> timers = [];

  Timer create(Duration delay, VoidCallback callback) {
    final timer = _ScheduledTimer(delay, callback);
    timers.add(timer);
    return timer;
  }
}

void main() {
  group('InterstitialAdManager', () {
    test(
      'retries transient network failures with a bounded number of loads',
      () {
        final timers = _FakeTimers();
        final callbacks = <InterstitialAdLoadCallback>[];
        var loadCount = 0;
        final manager = InterstitialAdManager(
          enabled: true,
          adUnitIdResolver: () => 'test-ad-unit',
          loadRetry: AdLoadRetry(createTimer: timers.create),
          loadInterstitialAd:
              ({required adUnitId, required request, required adLoadCallback}) {
                loadCount++;
                callbacks.add(adLoadCallback);
                return Future.value();
              },
        );

        manager.loadAd();
        callbacks[0].onAdFailedToLoad(_FakeLoadAdError(2));
        timers.timers[0].fire();
        callbacks[1].onAdFailedToLoad(_FakeLoadAdError(2));
        timers.timers[1].fire();
        callbacks[2].onAdFailedToLoad(_FakeLoadAdError(2));

        expect(loadCount, AdLoadRetry.maxAttempts);
        expect(timers.timers, hasLength(2));
        manager.dispose();
      },
    );

    test(
      'does not retry after disposal and disposes a late loaded ad',
      () async {
        final timers = _FakeTimers();
        final callbacks = <InterstitialAdLoadCallback>[];
        var loadCount = 0;
        final manager = InterstitialAdManager(
          enabled: true,
          adUnitIdResolver: () => 'test-ad-unit',
          loadRetry: AdLoadRetry(createTimer: timers.create),
          loadInterstitialAd:
              ({required adUnitId, required request, required adLoadCallback}) {
                loadCount++;
                callbacks.add(adLoadCallback);
                return Future.value();
              },
        );

        manager.loadAd();
        callbacks.single.onAdFailedToLoad(_FakeLoadAdError(2));
        manager.dispose();
        timers.timers.single.fire();
        final lateAd = _FakeInterstitialAd();
        callbacks.single.onAdLoaded(lateAd);
        await Future<void>.delayed(Duration.zero);

        expect(loadCount, 1);
        expect(lateAd.disposeCount, 1);
      },
    );
  });

  group('RewardedAdManager', () {
    test('retries a transient network load failure and remains bounded', () {
      final timers = _FakeTimers();
      final callbacks = <RewardedAdLoadCallback>[];
      var loadCount = 0;
      final manager = RewardedAdManager(
        enabled: true,
        adUnitIdResolver: () => 'test-ad-unit',
        loadRetry: AdLoadRetry(createTimer: timers.create),
        loadRewardedAd:
            ({
              required adUnitId,
              required request,
              required rewardedAdLoadCallback,
            }) {
              loadCount++;
              callbacks.add(rewardedAdLoadCallback);
              return Future.value();
            },
      );

      manager.loadAd();
      callbacks[0].onAdFailedToLoad(_FakeLoadAdError(2));
      timers.timers[0].fire();
      callbacks[1].onAdFailedToLoad(_FakeLoadAdError(2));
      timers.timers[1].fire();
      callbacks[2].onAdFailedToLoad(_FakeLoadAdError(2));

      expect(loadCount, AdLoadRetry.maxAttempts);
      expect(timers.timers, hasLength(2));
      manager.dispose();
    });

    test(
      'does not grant the same ad reward twice and ignores dismissal as a reward',
      () async {
        final callbacks = <RewardedAdLoadCallback>[];
        final ad = _FakeRewardedAd();
        final manager = RewardedAdManager(
          enabled: true,
          adUnitIdResolver: () => 'test-ad-unit',
          loadRewardedAd:
              ({
                required adUnitId,
                required request,
                required rewardedAdLoadCallback,
              }) {
                callbacks.add(rewardedAdLoadCallback);
                return Future.value();
              },
        );
        manager.loadAd();
        callbacks.single.onAdLoaded(ad);
        var rewards = 0;
        manager.showAd(placement: 'test', onUserEarnedReward: () => rewards++);
        await Future<void>.delayed(Duration.zero);

        ad.earnedReward!(ad, RewardItem(1, 'coin'));
        ad.earnedReward!(ad, RewardItem(1, 'coin'));
        expect(rewards, 1);

        ad.callback!.onAdDismissedFullScreenContent!(ad);
        ad.callback!.onAdDismissedFullScreenContent!(ad);
        expect(rewards, 1);
        expect(ad.disposeCount, 1);
        manager.dispose();
      },
    );
  });
}
