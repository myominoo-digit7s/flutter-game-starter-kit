import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../analytics/analytics_service.dart';
import '../config/environment_config.dart';
import '../utils/app_logger.dart';
import 'ad_unit_ids.dart';
import 'ad_load_retry.dart';

typedef RewardedAdLoader =
    Future<void> Function({
      required String adUnitId,
      required AdRequest request,
      required RewardedAdLoadCallback rewardedAdLoadCallback,
    });

class RewardedAdManager {
  final AnalyticsService? analytics;
  final bool enabled;
  final String? Function() _adUnitIdResolver;
  final RewardedAdLoader _loadRewardedAd;
  final AdLoadRetry _loadRetry;
  RewardedAd? _rewardedAd;
  bool _isAdLoading = false;
  bool _isDisposed = false;
  bool _isShowing = false;
  int _loadGeneration = 0;

  RewardedAdManager({
    this.analytics,
    this.enabled = EnvironmentConfig.adsEnabled,
    String? Function()? adUnitIdResolver,
    RewardedAdLoader? loadRewardedAd,
    AdLoadRetry? loadRetry,
  }) : _adUnitIdResolver =
           adUnitIdResolver ?? (() => AdUnitIds.rewardedAdUnitId),
       _loadRewardedAd = loadRewardedAd ?? _loadWithGoogleMobileAds,
       _loadRetry = loadRetry ?? AdLoadRetry();

  static Future<void> _loadWithGoogleMobileAds({
    required String adUnitId,
    required AdRequest request,
    required RewardedAdLoadCallback rewardedAdLoadCallback,
  }) => RewardedAd.load(
    adUnitId: adUnitId,
    request: request,
    rewardedAdLoadCallback: rewardedAdLoadCallback,
  );

  void loadAd() {
    if (!enabled || _isDisposed) return;
    if (_isAdLoading || _rewardedAd != null) return;

    if (!AdUnitIds.hasRequiredIdsForCurrentBuild) {
      AppLogger.error(
        'Rewarded ad request skipped because release ad unit IDs are '
        'incomplete.',
      );
      return;
    }

    final adUnitId = _adUnitIdResolver();
    if (adUnitId == null) {
      AppLogger.error(
        'Rewarded ad request skipped because this platform has no '
        'configured ad unit ID.',
      );
      return;
    }

    _isAdLoading = true;
    final generation = ++_loadGeneration;
    Future<void>.sync(
      () => _loadRewardedAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            if (_isDisposed ||
                generation != _loadGeneration ||
                _rewardedAd != null) {
              unawaited(ad.dispose());
              return;
            }
            _rewardedAd = ad;
            _isAdLoading = false;
            _loadRetry.onLoaded();
          },
          onAdFailedToLoad: (error) {
            if (_isDisposed || generation != _loadGeneration) return;
            AppLogger.error('RewardedAd failed to load: $error');
            _isAdLoading = false;
            _loadRetry.onFailed(error.code, loadAd);
          },
        ),
      ),
    ).catchError((Object error, StackTrace stackTrace) {
      if (_isDisposed || generation != _loadGeneration) return;
      _isAdLoading = false;
      AppLogger.error(
        'RewardedAd load request failed: $error',
        error,
        stackTrace,
      );
    });
  }

  void showAd({
    required String placement,
    required VoidCallback onUserEarnedReward,
    VoidCallback? onAdClosed,
    VoidCallback? onAdFailed,
  }) {
    if (!enabled || _isDisposed) {
      onAdFailed?.call();
      return;
    }
    if (_rewardedAd == null) {
      AppLogger.log('Rewarded ad not ready.');
      onAdFailed?.call();
      return;
    }

    if (_isShowing) {
      onAdFailed?.call();
      return;
    }

    final ad = _rewardedAd!;
    var handled = false;
    var rewardGranted = false;
    void finish({AdError? error, bool failed = false}) {
      if (_isDisposed) {
        handled = true;
        return;
      }
      if (handled) return;
      handled = true;
      _isShowing = false;
      if (error != null) {
        analytics?.logRewardedAdFailed(
          placement: placement,
          errorMessage: error.message,
          errorCode: error.code.toString(),
        );
        AppLogger.error('Failed to show rewarded ad: $error');
      }
      unawaited(ad.dispose());
      if (identical(_rewardedAd, ad)) {
        _rewardedAd = null;
        if (!_isDisposed) loadAd();
      }
      if (error == null && !failed) {
        onAdClosed?.call();
      } else {
        onAdFailed?.call();
      }
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        finish();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        finish(error: error);
      },
    );

    _isShowing = true;
    unawaited(
      ad
          .show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              if (rewardGranted || handled || _isDisposed) return;
              rewardGranted = true;
              analytics?.logRewardedAdCompleted(
                placement: placement,
                rewardType: reward.type,
                rewardAmount: reward.amount.toInt(),
              );
              onUserEarnedReward();
            },
          )
          .catchError((Object error, StackTrace stackTrace) {
            AppLogger.error(
              'RewardedAd show request failed: $error',
              error,
              stackTrace,
            );
            finish(failed: true);
          }),
    );
    analytics?.logRewardedAdShown(placement: placement);
  }

  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _loadGeneration++;
    _loadRetry.dispose();
    final ad = _rewardedAd;
    _rewardedAd = null;
    if (ad != null) unawaited(ad.dispose());
  }
}
