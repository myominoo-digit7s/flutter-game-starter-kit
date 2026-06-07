import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../analytics/analytics_service.dart';
import '../utils/app_logger.dart';
import 'ad_placement.dart';
import 'ad_placement_policy.dart';
import 'ad_unit_ids.dart';

class InterstitialAdManager {
  final AnalyticsService? analytics;
  InterstitialAd? _interstitialAd;
  bool _isAdLoading = false;

  InterstitialAdManager({this.analytics});

  void loadAd() {
    if (_isAdLoading || _interstitialAd != null) return;

    _isAdLoading = true;
    InterstitialAd.load(
      adUnitId: AdUnitIds.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoading = false;
          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  _interstitialAd = null;
                  loadAd(); // Preload next ad
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  AppLogger.error('Failed to show interstitial ad: $error');
                  ad.dispose();
                  _interstitialAd = null;
                  loadAd();
                },
              );
        },
        onAdFailedToLoad: (error) {
          AppLogger.error('InterstitialAd failed to load: $error');
          _isAdLoading = false;
        },
      ),
    );
  }

  void showAdIfAppropriate(AdPlacement placement, {VoidCallback? onComplete}) {
    if (!AdPlacementPolicy.shouldShowInterstitial(placement)) {
      onComplete?.call();
      return;
    }

    if (_interstitialAd == null) {
      AppLogger.log('Interstitial ad not ready.');
      onComplete?.call();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        loadAd();
        onComplete?.call();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        analytics?.logInterstitialFailed(
          placement: placement.name,
          errorMessage: error.message,
          errorCode: error.code.toString(),
        );
        AppLogger.error('Failed to show interstitial: $error');
        ad.dispose();
        _interstitialAd = null;
        loadAd();
        onComplete?.call();
      },
    );

    _interstitialAd!.show();
    analytics?.logInterstitialShown(placement: placement.name);
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
