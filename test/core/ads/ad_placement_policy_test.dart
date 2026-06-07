import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/ads/ad_placement.dart';
import 'package:flutter_game_starter_kit/core/ads/ad_placement_policy.dart';

void main() {
  group('AdPlacementPolicy', () {
    test('does not show banner in gameplay', () {
      expect(AdPlacementPolicy.shouldShowBanner(AdPlacement.gameplay), isFalse);
      expect(AdPlacementPolicy.shouldShowBanner(AdPlacement.gameOver), isFalse);
    });

    test('shows banner in menu screens', () {
      expect(
        AdPlacementPolicy.shouldShowBanner(AdPlacement.homeScreen),
        isTrue,
      );
      expect(
        AdPlacementPolicy.shouldShowBanner(AdPlacement.shopScreen),
        isTrue,
      );
      expect(
        AdPlacementPolicy.shouldShowBanner(AdPlacement.settingsScreen),
        isTrue,
      );
      expect(
        AdPlacementPolicy.shouldShowBanner(AdPlacement.leaderboardScreen),
        isTrue,
      );
    });

    test('shows interstitial on game over', () {
      expect(
        AdPlacementPolicy.shouldShowInterstitial(AdPlacement.gameOver),
        isTrue,
      );
      expect(
        AdPlacementPolicy.shouldShowInterstitial(AdPlacement.homeScreen),
        isFalse,
      );
    });
  });
}
