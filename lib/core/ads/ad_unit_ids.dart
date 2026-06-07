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

  static String get bannerAdUnitId {
    const prodIdAndroid = String.fromEnvironment('BANNER_AD_ID_ANDROID');
    const prodIdIOS = String.fromEnvironment('BANNER_AD_ID_IOS');

    if (kReleaseMode) {
      if (Platform.isAndroid && prodIdAndroid.isNotEmpty) return prodIdAndroid;
      if (Platform.isIOS && prodIdIOS.isNotEmpty) return prodIdIOS;
    }

    return Platform.isAndroid ? _testBannerAndroid : _testBannerIOS;
  }

  static String get interstitialAdUnitId {
    const prodIdAndroid = String.fromEnvironment('INTERSTITIAL_AD_ID_ANDROID');
    const prodIdIOS = String.fromEnvironment('INTERSTITIAL_AD_ID_IOS');

    if (kReleaseMode) {
      if (Platform.isAndroid && prodIdAndroid.isNotEmpty) return prodIdAndroid;
      if (Platform.isIOS && prodIdIOS.isNotEmpty) return prodIdIOS;
    }

    return Platform.isAndroid ? _testInterstitialAndroid : _testInterstitialIOS;
  }

  static String get rewardedAdUnitId {
    const prodIdAndroid = String.fromEnvironment('REWARDED_AD_ID_ANDROID');
    const prodIdIOS = String.fromEnvironment('REWARDED_AD_ID_IOS');

    if (kReleaseMode) {
      if (Platform.isAndroid && prodIdAndroid.isNotEmpty) return prodIdAndroid;
      if (Platform.isIOS && prodIdIOS.isNotEmpty) return prodIdIOS;
    }

    return Platform.isAndroid ? _testRewardedAndroid : _testRewardedIOS;
  }
}
