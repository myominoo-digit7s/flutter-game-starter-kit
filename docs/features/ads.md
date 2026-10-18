# AdMob Integration

AdMob is optional and disabled by default. This lets the demo run without
initializing the Mobile Ads SDK or making ad requests.

## Enable development test ads

Pass the build-time flag when running or building a development app:

```bash
flutter run --dart-define=ENABLE_ADS=true
```

Debug and profile builds use Google's official test ad unit IDs. The existing
placement policy suppresses banners during gameplay and game-over overlays.
Interstitial and rewarded managers retain their existing callbacks when ads
are enabled.

## Release configuration

When release ads are enabled, the current implementation requires production
IDs for **all three formats**—banner, interstitial, and rewarded—for the target
platform. Supply them at build time:

```bash
flutter build appbundle \
  --dart-define=ENABLE_ADS=true \
  --dart-define=BANNER_AD_ID_ANDROID=ca-app-pub-xxxx/xxxx \
  --dart-define=INTERSTITIAL_AD_ID_ANDROID=ca-app-pub-xxxx/xxxx \
  --dart-define=REWARDED_AD_ID_ANDROID=ca-app-pub-xxxx/xxxx
```

Use the `_IOS` names for iOS builds. `AdUnitIds.hasProductionIds` checks all
three platform-specific values. If any one is missing, release ad
initialization and requests are skipped with a debug diagnostic; the code does
not fall back to Google's test unit IDs. Replace the sample
AdMob **App IDs** in `android/app/src/main/AndroidManifest.xml` and
`ios/Runner/Info.plist` for the app as well. These public app/unit identifiers
are not secrets, but they must identify the correct AdMob app and placement.

AdMob initialization and placements are implemented in `AdService`,
`AdUnitIds`, `AdPlacementPolicy`, `BannerAdWidget`, and the interstitial and
rewarded managers under `lib/core/ads/`. This integration does not implement
consent collection or determine whether a particular audience, region, or
release meets privacy and store requirements. Configure consent and disclosure
for the actual game when applicable.
