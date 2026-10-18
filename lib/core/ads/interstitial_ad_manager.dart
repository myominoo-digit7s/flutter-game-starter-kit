import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../analytics/analytics_service.dart';
import '../config/environment_config.dart';
import '../utils/app_logger.dart';
import 'ad_placement.dart';
import 'ad_placement_policy.dart';
import 'ad_unit_ids.dart';
import 'ad_load_retry.dart';

typedef InterstitialAdLoader =
    Future<void> Function({
      required String adUnitId,
      required AdRequest request,
      required InterstitialAdLoadCallback adLoadCallback,
    });

class InterstitialAdManager {
  final AnalyticsService? analytics;
  final bool enabled;
  final String? Function() _adUnitIdResolver;
  final InterstitialAdLoader _loadInterstitialAd;
  final AdLoadRetry _loadRetry;
  InterstitialAd? _interstitialAd;
  bool _isAdLoading = false;
  bool _isDisposed = false;
  bool _isShowing = false;
  int _loadGeneration = 0;

  InterstitialAdManager({
    this.analytics,
    this.enabled = EnvironmentConfig.adsEnabled,
    String? Function()? adUnitIdResolver,
    InterstitialAdLoader? loadInterstitialAd,
    AdLoadRetry? loadRetry,
  }) : _adUnitIdResolver =
           adUnitIdResolver ?? (() => AdUnitIds.interstitialAdUnitId),
       _loadInterstitialAd = loadInterstitialAd ?? _loadWithGoogleMobileAds,
       _loadRetry = loadRetry ?? AdLoadRetry();

  static Future<void> _loadWithGoogleMobileAds({
    required String adUnitId,
    required AdRequest request,
    required InterstitialAdLoadCallback adLoadCallback,
  }) => InterstitialAd.load(
    adUnitId: adUnitId,
    request: request,
    adLoadCallback: adLoadCallback,
  );

  void loadAd() {
    if (!enabled || _isDisposed) return;
    if (_isAdLoading || _interstitialAd != null) return;

    if (!AdUnitIds.hasRequiredIdsForCurrentBuild) {
      AppLogger.error(
        'Interstitial ad request skipped because release ad unit IDs are '
        'incomplete.',
      );
      return;
    }

    final adUnitId = _adUnitIdResolver();
    if (adUnitId == null) {
      AppLogger.error(
        'Interstitial ad request skipped because this platform has no '
        'configured ad unit ID.',
      );
      return;
    }

    _isAdLoading = true;
    final generation = ++_loadGeneration;
    Future<void>.sync(
      () => _loadInterstitialAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            if (_isDisposed ||
                generation != _loadGeneration ||
                _interstitialAd != null) {
              unawaited(ad.dispose());
              return;
            }
            _interstitialAd = ad;
            _isAdLoading = false;
            _loadRetry.onLoaded();
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _finishAd(ad);
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                AppLogger.error('Failed to show interstitial ad: $error');
                _finishAd(ad);
              },
            );
          },
          onAdFailedToLoad: (error) {
            if (_isDisposed || generation != _loadGeneration) return;
            AppLogger.error('InterstitialAd failed to load: $error');
            _isAdLoading = false;
            _loadRetry.onFailed(error.code, loadAd);
          },
        ),
      ),
    ).catchError((Object error, StackTrace stackTrace) {
      if (_isDisposed || generation != _loadGeneration) return;
      _isAdLoading = false;
      AppLogger.error(
        'InterstitialAd load request failed: $error',
        error,
        stackTrace,
      );
    });
  }

  void _finishAd(Ad ad) {
    if (_isDisposed) return;
    if (!_isShowing && _interstitialAd == null) return;
    _isShowing = false;
    unawaited(ad.dispose());
    if (identical(_interstitialAd, ad)) {
      _interstitialAd = null;
      if (!_isDisposed) loadAd();
    }
  }

  void showAdIfAppropriate(AdPlacement placement, {VoidCallback? onComplete}) {
    if (!enabled || _isDisposed) {
      onComplete?.call();
      return;
    }
    if (!AdPlacementPolicy.shouldShowInterstitial(placement)) {
      onComplete?.call();
      return;
    }

    if (_interstitialAd == null) {
      AppLogger.log('Interstitial ad not ready.');
      onComplete?.call();
      return;
    }

    if (_isShowing) {
      onComplete?.call();
      return;
    }

    final ad = _interstitialAd!;
    var handled = false;
    void completeOnce({AdError? error}) {
      if (handled || _isDisposed) return;
      handled = true;
      if (error != null) {
        analytics?.logInterstitialFailed(
          placement: placement.name,
          errorMessage: error.message,
          errorCode: error.code.toString(),
        );
        AppLogger.error('Failed to show interstitial: $error');
      }
      _finishAd(ad);
      onComplete?.call();
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        completeOnce();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        completeOnce(error: error);
      },
    );

    _isShowing = true;
    unawaited(
      ad.show().catchError((Object error, StackTrace stackTrace) {
        AppLogger.error(
          'InterstitialAd show request failed: $error',
          error,
          stackTrace,
        );
        completeOnce();
      }),
    );
    analytics?.logInterstitialShown(placement: placement.name);
  }

  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _loadGeneration++;
    _loadRetry.dispose();
    final ad = _interstitialAd;
    _interstitialAd = null;
    if (ad != null) unawaited(ad.dispose());
  }
}
