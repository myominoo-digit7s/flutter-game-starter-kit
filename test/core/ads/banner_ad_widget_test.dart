import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_game_starter_kit/core/ads/ad_placement.dart';
import 'package:flutter_game_starter_kit/core/ads/widgets/banner_ad_widget.dart';

class _FakeBannerAd extends Fake implements BannerAd {
  int disposeCount = 0;

  @override
  Future<void> load() async {}

  @override
  Future<void> dispose() async {
    disposeCount++;
  }
}

void main() {
  testWidgets(
    'late load callback after unmount is harmless and disposes once',
    (tester) async {
      final ad = _FakeBannerAd();
      BannerAdListener? loadedListener;

      await tester.pumpWidget(
        MaterialApp(
          home: BannerAdWidget(
            placement: AdPlacement.homeScreen,
            enabled: true,
            adUnitIdResolver: () => 'test-ad-unit',
            createBannerAd:
                ({
                  required adUnitId,
                  required request,
                  required size,
                  required listener,
                }) {
                  loadedListener = listener;
                  return ad;
                },
          ),
        ),
      );

      expect(loadedListener, isNotNull);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(ad.disposeCount, 1);

      loadedListener!.onAdLoaded!(ad);
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(ad.disposeCount, 1);
    },
  );

  testWidgets('disabled banner does not construct an ad', (tester) async {
    var factoryCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: BannerAdWidget(
          placement: AdPlacement.homeScreen,
          enabled: false,
          adUnitIdResolver: () => 'test-ad-unit',
          createBannerAd:
              ({
                required adUnitId,
                required request,
                required size,
                required listener,
              }) {
                factoryCalled = true;
                return _FakeBannerAd();
              },
        ),
      ),
    );

    expect(factoryCalled, isFalse);
    expect(find.byType(AdWidget), findsNothing);
  });
}
