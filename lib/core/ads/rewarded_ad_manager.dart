import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../analytics/analytics_service.dart';
import '../utils/app_logger.dart';
import 'ad_unit_ids.dart';

class RewardedAdManager {
  final AnalyticsService? analytics;
  RewardedAd? _rewardedAd;
  bool _isAdLoading = false;

  RewardedAdManager({this.analytics});

  void loadAd() {
    if (_isAdLoading || _rewardedAd != null) return;

    _isAdLoading = true;
    RewardedAd.load(
      adUnitId: AdUnitIds.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoading = false;
        },
        onAdFailedToLoad: (error) {
          AppLogger.error('RewardedAd failed to load: $error');
          _isAdLoading = false;
        },
      ),
    );
  }

  void showAd({
    required String placement,
    required VoidCallback onUserEarnedReward,
    VoidCallback? onAdClosed,
    VoidCallback? onAdFailed,
  }) {
    if (_rewardedAd == null) {
      AppLogger.log('Rewarded ad not ready.');
      onAdFailed?.call();
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        loadAd();
        onAdClosed?.call();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        analytics?.logRewardedAdFailed(
          placement: placement,
          errorMessage: error.message,
          errorCode: error.code.toString(),
        );
        AppLogger.error('Failed to show rewarded ad: $error');
        ad.dispose();
        _rewardedAd = null;
        loadAd();
        onAdFailed?.call();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        analytics?.logRewardedAdCompleted(
          placement: placement,
          rewardType: reward.type,
          rewardAmount: reward.amount.toInt(),
        );
        onUserEarnedReward();
      },
    );
    analytics?.logRewardedAdShown(placement: placement);
  }

  void dispose() {
    _rewardedAd?.dispose();
  }
}
