import 'ad_placement.dart';

class AdPlacementPolicy {
  /// Determines if a banner ad should be shown for a given placement.
  static bool shouldShowBanner(AdPlacement placement) {
    switch (placement) {
      case AdPlacement.gameplay:
      case AdPlacement.gameOver:
        return false; // Do not show banner ads during gameplay by default
      case AdPlacement.homeScreen:
      case AdPlacement.shopScreen:
      case AdPlacement.leaderboardScreen:
      case AdPlacement.settingsScreen:
        return true;
    }
  }

  /// Determines if an interstitial ad should be shown after a transition.
  static bool shouldShowInterstitial(AdPlacement placement) {
    switch (placement) {
      case AdPlacement.gameOver:
        return true;
      default:
        return false;
    }
  }
}
