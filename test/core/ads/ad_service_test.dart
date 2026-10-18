import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_game_starter_kit/core/ads/ad_service.dart';
import 'package:flutter_game_starter_kit/core/ads/interstitial_ad_manager.dart';
import 'package:flutter_game_starter_kit/core/ads/rewarded_ad_manager.dart';
import 'package:flutter_game_starter_kit/core/ads/ad_placement.dart';
import 'package:flutter_game_starter_kit/core/ads/widgets/banner_ad_widget.dart';

void main() {
  group('Optional AdMob integration', () {
    test('disabled service does not initialize the SDK', () async {
      var initialized = false;
      final service = AdService(
        enabled: false,
        initializeSdk: () async => initialized = true,
      );

      await service.initialize();

      expect(initialized, isFalse);
    });

    test(
      'enabled service initializes the SDK through its configured hook',
      () async {
        var initialized = false;
        final service = AdService(
          enabled: true,
          initializeSdk: () async => initialized = true,
        );

        await service.initialize();

        expect(initialized, isTrue);
      },
    );

    test('disabled ad managers do not request or show ads', () {
      final interstitial = InterstitialAdManager(enabled: false);
      final rewarded = RewardedAdManager(enabled: false);
      var interstitialCompleted = false;
      var rewardedFailed = false;

      expect(() => interstitial.loadAd(), returnsNormally);
      expect(() => rewarded.loadAd(), returnsNormally);
      interstitial.showAdIfAppropriate(
        AdPlacement.gameOver,
        onComplete: () => interstitialCompleted = true,
      );
      rewarded.showAd(
        placement: 'test',
        onUserEarnedReward: () => fail('Disabled ads cannot grant rewards.'),
        onAdFailed: () => rewardedFailed = true,
      );

      expect(interstitialCompleted, isTrue);
      expect(rewardedFailed, isTrue);
    });

    testWidgets('disabled banner does not create an ad request', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BannerAdWidget(
            placement: AdPlacement.homeScreen,
            enabled: false,
          ),
        ),
      );

      expect(find.byType(AdWidget), findsNothing);
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
