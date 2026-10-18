# Data Safety Guide

## Google Play Data safety

The in-app `DataSafetyScreen` is a developer checklist generated from
`ComplianceConfig`; its flags are prompts, not automatic answers for Play
Console. Review the finished app's code and each SDK's actual behavior,
including data collected or shared by libraries, before completing the
[Google Play Data safety form](https://support.google.com/googleplay/android-developer/answer/10787469).
Declarations depend on the app's actual integrations, data flows, purposes,
and applicable form definitions; do not infer them from a permission or a
configuration flag alone.

## Apple App Store

App Store Connect privacy details are a separate declaration from Google Play
Data safety. Review the app and SDK behavior against Apple's current
[App privacy details](https://developer.apple.com/app-store/app-privacy-details/)
guidance and complete the applicable information in App Store Connect.

For either store, keep declarations, privacy notices, and the shipped app's
behavior consistent. Recheck them when integrations or SDK settings change.
