# Ads Disclosure Guide

## Store and in-app disclosures

Describe ads and ad-related data handling accurately in each store's current
submission forms and in the app where users need that context. Google Play
and App Store Connect have separate declarations; use the relevant
[Google Play Ads policy](https://support.google.com/googleplay/android-developer/answer/9857753)
and [Apple App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
for the finished game. Place banners so they do not obscure interactive game
controls. Show interstitials at appropriate transitions, and explain the
reward before an optional rewarded ad.

## Test vs Production Ad IDs
Use Google's test ad IDs during development. The starter uses test IDs for
debug/profile builds and requires all three production format IDs for the
target platform in release builds when ads are enabled; see the
[AdMob guide](../features/ads.md). Review native App IDs and store declarations
separately.

## Kids/Family Ads Warning
If the game targets children or a mixed audience, check the current platform
and regional requirements before choosing ad SDKs or serving ads. Google Play
has specific [Families Policy requirements](https://support.google.com/googleplay/android-developer/answer/9893335)
for apps and ads involving children, including requirements for applicable ad
SDKs and audiences of unknown age. Do not assume every SDK collects the same
data or that this starter configures child-directed treatment: the current
integration creates default ad requests and does not implement age screening
or audience-specific request handling. Review actual SDK behavior and the
Apple submission requirements separately.
