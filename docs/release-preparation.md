# Release Preparation

This checklist prepares a customized game for platform review. It does not
configure production services, validate a signed release, or approve a store
submission. A GitHub Actions validation workflow is configured in
`.github/workflows/ci.yml`; its latest hosted result must be checked in the
repository's Actions tab for the commit or pull request under review. At this
review (2026-10-18), the workflow file was not yet present on GitHub and the
repository had no hosted workflow runs, so hosted execution was not verified.
That status can change after publication; local workflow files alone are not
evidence that GitHub has executed CI.

The workflow's Android debug APK build checks the debug configuration only.
It does not establish production release readiness. A signed Android App
Bundle (AAB) and an iOS archive require separate, owner-configured signing and
verification; neither is produced by the workflow.

## Toolchain and versioning

The workflow is configured for Flutter 3.41.2 with Dart 3.11.0 on the stable
channel, which is also the locally validated baseline. `pubspec.yaml` requires
Dart `^3.11.0`; the committed `pubspec.lock` records the resolved application
dependencies. Keep that lock file committed and use
`flutter pub get --enforce-lockfile` to confirm the current dependency graph.
Update the CI Flutter version only after validating the new toolchain.

Set the app's version in `pubspec.yaml` as `major.minor.patch+build`, for
example `1.2.0+3`. Increment the build number for each platform upload. For an
open-source template, use Git tags for source milestones only when a maintainer
has reviewed the corresponding commit; no release automation or store upload
is configured here.

## Android

Before a game release, set a unique application ID and matching namespace in
`android/app/build.gradle.kts`, update the launcher label and icons, and review
the manifest, SDK levels, permissions, and any SDK-specific metadata. The
current application ID is still the template value. Android's manifest
contains Google's sample AdMob App ID; replace it with the app's own public
AdMob App ID only if ads will be enabled. Production ad unit IDs are supplied
at build time as described in the [AdMob guide](features/ads.md).

Create an upload key outside the repository and keep both the keystore and
`android/key.properties` private and backed up securely. The ignored
`android/key.properties` file must contain:

```properties
storeFile=/absolute/path/to/upload-keystore.jks
storePassword=...
keyAlias=...
keyPassword=...
```

Use the upload key and app signing settings configured in Google Play Console.
Release tasks intentionally fail if a required property is missing or the
keystore path does not exist; release builds never fall back to debug signing.
After configuring credentials, build locally:

```bash
flutter build appbundle --release
```

For an app using AdMob, pass the production `--dart-define` values described in
the AdMob guide and replace the sample native App ID. Review the resulting AAB,
version, signing certificate, store listing, data safety form, privacy policy,
content rating, target audience, and any applicable consent requirements
before upload. CI does not create or sign release artifacts.

## iOS

Use a supported macOS installation with Xcode and CocoaPods. Run
`flutter pub get`, then `cd ios && pod install` when native dependencies need
resolution; open `ios/Runner.xcworkspace` for Xcode configuration. Set a unique
`PRODUCT_BUNDLE_IDENTIFIER`, app display name, icons, deployment target, and
your own Apple development team and signing settings for the game. Select your
Apple Development Team in Xcode's Signing & Capabilities for the Runner and
any other targets that require signing; the public template does not select
an owner-specific team. The deployment target is iOS 15.0 to satisfy the
minimum required by the currently locked Firebase Analytics iOS pod. If you
change Firebase versions, recheck the plugin's minimum supported iOS version
before lowering this target.

The iOS `Info.plist` contains Google's sample AdMob App ID. Replace it only
when enabling ads, and supply the iOS production ad unit IDs with the
`_IOS` build defines documented in the AdMob guide. Declare only the privacy
usage descriptions and capabilities required by the actual game and its SDKs.

For local simulator validation, use `flutter build ios --simulator --no-codesign`.
An App Store archive requires valid signing identities, provisioning, the
appropriate Apple Developer account, and review of entitlements, privacy
details, icons, versioning, and store metadata. Neither a simulator build nor
the repository's Android CI verifies an archive or submission.

## Before publishing

- Configure your own Android application ID, iOS bundle identifier, Apple
  Development Team, and platform signing settings. Validate signed release
  artifacts with owner-controlled credentials on each target platform.
- Check the current GitHub Actions run for the commit or pull request under
  review; do not treat a locally configured workflow as a hosted CI pass.
- Test installation, startup, lifecycle changes, audio, ads if enabled, and
  data handling on physical devices.
- Complete current Google Play and App Store privacy, age-rating, audience,
  permission, and SDK declarations for the finished game.
- Replace the compliance examples with accurate game-specific policies and
  disclosures; the included screens are checklists, not legal compliance.
- Have a maintainer review the source commit and prepare release notes. No
publishing or automated release action is present in this repository.
