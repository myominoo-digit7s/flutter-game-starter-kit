# AdMob Architecture

The Flutter Game Starter Kit includes a ready-to-use AdMob architecture built around the `google_mobile_ads` package. It provides safe handling of Banner, Interstitial, and Rewarded ads.

## Configuration & Environment Variables

By default, the app uses **Google's official Test Ad Unit IDs**. During development, you should *always* use test ads to prevent your AdMob account from being flagged for invalid traffic.

When you are ready to deploy your app, you should inject your production Ad Unit IDs via `--dart-define` at compile time. The architecture automatically falls back to test IDs if production IDs are not provided or if the app is built in debug mode.

### How to Build with Production Ads:
```bash
flutter build apk \
  --dart-define=BANNER_AD_ID_ANDROID=ca-app-pub-xxxx/xxxx \
  --dart-define=INTERSTITIAL_AD_ID_ANDROID=ca-app-pub-xxxx/xxxx \
  --dart-define=REWARDED_AD_ID_ANDROID=ca-app-pub-xxxx/xxxx
```
*(Repeat the equivalent for iOS variables: `BANNER_AD_ID_IOS`, etc.)*

## Components

### 1. `AdService`
Initializes the Google Mobile Ads SDK on app startup.

### 2. `AdUnitIds`
A utility class that resolves the correct Ad Unit ID depending on the current `Platform` (iOS/Android) and build mode (Debug/Release).

### 3. `AdPlacement` & `AdPlacementPolicy`
`AdPlacement` is an enum defining all the screens and locations where ads *could* potentially appear (e.g., `homeScreen`, `gameplay`, `gameOver`).

`AdPlacementPolicy` contains the business logic to determine if an ad *should* appear. For example, it enforces the rule: **Do not show banner ads during gameplay by default**.

### 4. `BannerAdWidget`
A reusable Flutter widget that requests and displays a `BannerAd`. It takes an `AdPlacement` and respects the `AdPlacementPolicy`. If the policy dictates no ad should be shown, it safely returns an empty `SizedBox.shrink()`.

**Usage:**
```dart
const BannerAdWidget(placement: AdPlacement.homeScreen),
```

### 5. `InterstitialAdManager`
Preloads and manages fullscreen interstitial ads. It automatically preloads the next ad once the current one is dismissed.

**Usage:**
```dart
final interstitialManager = context.read<InterstitialAdManager>();
interstitialManager.showAdIfAppropriate(
  AdPlacement.gameOver,
  onComplete: () {
    // Navigate back to menu or restart game
  },
);
```

### 6. `RewardedAdManager`
Preloads and manages rewarded video ads. Useful for offering the player a "Revive" or bonus coins in the shop.

**Usage:**
```dart
final rewardedManager = context.read<RewardedAdManager>();
rewardedManager.showAd(
  onUserEarnedReward: () {
    // Grant player coins or revive them
  },
  onAdClosed: () {
    // Resume game flow
  },
);
```
