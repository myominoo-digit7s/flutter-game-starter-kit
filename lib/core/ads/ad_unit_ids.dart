import 'dart:io';
import 'package:flutter/foundation.dart';

class AdUnitIds {
  // Test IDs provided by Google
  static const String _testBannerAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _testBannerIOS = 'ca-app-pub-3940256099942544/2934735716';

  static const String _testInterstitialAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _testInterstitialIOS =
      'ca-app-pub-3940256099942544/4411468910';

  static const String _testRewardedAndroid =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _testRewardedIOS =
      'ca-app-pub-3940256099942544/1712485313';

  static String? get bannerAdUnitId {
    const prodIdAndroid = String.fromEnvironment('BANNER_AD_ID_ANDROID');
    const prodIdIOS = String.fromEnvironment('BANNER_AD_ID_IOS');

    return _resolve(
      androidProductionId: prodIdAndroid,
      iosProductionId: prodIdIOS,
      androidTestId: _testBannerAndroid,
      iosTestId: _testBannerIOS,
    );
  }

  static String? get interstitialAdUnitId {
    const prodIdAndroid = String.fromEnvironment('INTERSTITIAL_AD_ID_ANDROID');
    const prodIdIOS = String.fromEnvironment('INTERSTITIAL_AD_ID_IOS');

    return _resolve(
      androidProductionId: prodIdAndroid,
      iosProductionId: prodIdIOS,
      androidTestId: _testInterstitialAndroid,
      iosTestId: _testInterstitialIOS,
    );
  }

  static String? get rewardedAdUnitId {
    const prodIdAndroid = String.fromEnvironment('REWARDED_AD_ID_ANDROID');
    const prodIdIOS = String.fromEnvironment('REWARDED_AD_ID_IOS');

    return _resolve(
      androidProductionId: prodIdAndroid,
      iosProductionId: prodIdIOS,
      androidTestId: _testRewardedAndroid,
      iosTestId: _testRewardedIOS,
    );
  }

  static bool get hasProductionIds {
    final banner = _productionIds(
      const String.fromEnvironment('BANNER_AD_ID_ANDROID'),
      const String.fromEnvironment('BANNER_AD_ID_IOS'),
    );
    final interstitial = _productionIds(
      const String.fromEnvironment('INTERSTITIAL_AD_ID_ANDROID'),
      const String.fromEnvironment('INTERSTITIAL_AD_ID_IOS'),
    );
    final rewarded = _productionIds(
      const String.fromEnvironment('REWARDED_AD_ID_ANDROID'),
      const String.fromEnvironment('REWARDED_AD_ID_IOS'),
    );
    return banner && interstitial && rewarded;
  }

  static bool get hasRequiredIdsForCurrentBuild =>
      !kReleaseMode || hasProductionIds;

  static bool _productionIds(String androidId, String iosId) {
    if (Platform.isAndroid) return androidId.isNotEmpty;
    if (Platform.isIOS) return iosId.isNotEmpty;
    return false;
  }

  static String? _resolve({
    required String androidProductionId,
    required String iosProductionId,
    required String androidTestId,
    required String iosTestId,
  }) {
    if (kReleaseMode) {
      if (Platform.isAndroid && androidProductionId.isNotEmpty) {
        return androidProductionId;
      }
      if (Platform.isIOS && iosProductionId.isNotEmpty) return iosProductionId;
      return null;
    }

    if (Platform.isAndroid) return androidTestId;
    if (Platform.isIOS) return iosTestId;
    return null;
  }
}
