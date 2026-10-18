# Create a New Game

This repository is a single-game starter template. Demo Collector remains the
runnable example; replace it at the app router's game factory when building an
independent game. Shared settings, audio, storage, localization, the Flame game
shell, and optional integrations remain available through the existing app.

## 1. Run the starter

Use a Flutter SDK compatible with `pubspec.yaml`, then run:

```bash
flutter pub get
flutter run
flutter analyze
flutter test
flutter build apk --debug
```

AdMob and Firebase telemetry are disabled by default. The game runs without
those integrations or their project configuration.

## 2. Set the game identity

Create `lib/games/my_game/my_game.dart` and extend `BaseFlameGame`. Its
constructor requires a unique analytics ID and display name, and accepts the
shared audio service and optional analytics service:

```dart
import 'package:flutter_game_starter_kit/core/analytics/analytics_service.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';
import 'package:flutter_game_starter_kit/core/game/base_flame_game.dart';

class MyGame extends BaseFlameGame {
  MyGame({required AudioService audioService, AnalyticsService? analyticsService})
      : super(
          audioService: audioService,
          analyticsService: analyticsService,
          gameId: 'my_game',
          gameName: 'My Game',
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Add this game's Flame components.
  }
}
```

Use your own stable `gameId`; the game name is the human-readable analytics
label. The game base provides `scoreManager`, `startGame`, `pauseGame`,
`resumeGame`, `restartGame`, and `endGame`. Call `endGame()` when gameplay ends.

## 3. Select it through the existing shell

In `lib/app/router/app_router.dart`, replace the Demo Collector import and the
`gameFactory` on `AppRoutes.game` with your game:

```dart
builder: (context, state) => GameShellScreen(
  gameFactory: (audioService, analyticsService) => MyGame(
    audioService: audioService,
    analyticsService: analyticsService,
  ),
),
```

The shell supplies the shared HUD, pause, and game-over overlays and binds the
shared game result to the existing interstitial manager. Add game-specific
behavior in your game module; do not add it to `core/` unless another shared
consumer needs it.

## 4. Configure app branding and identifiers

This template retains its current identity until you change it. Update these
platform-specific values for your own release:

- Android application ID and namespace: `android/app/build.gradle.kts`.
- Android launcher label: `android/app/src/main/AndroidManifest.xml`.
- Android launcher icons: `android/app/src/main/res/mipmap-*`.
- iOS bundle identifier: `PRODUCT_BUNDLE_IDENTIFIER` in
  `ios/Runner.xcodeproj/project.pbxproj`.
- iOS display name and AdMob App ID: `ios/Runner/Info.plist`.
- iOS app icons and launch images: `ios/Runner/Assets.xcassets/`.
- Flutter package name used by imports: `name` in `pubspec.yaml`; renaming it
  requires updating package imports.
- App version/build number: `version` in `pubspec.yaml`.
- App metadata title: `AppConfig.appName` in `lib/core/config/app_config.dart`.
- Home screen title: `appTitle` in the translated ARB files.
- Default locale: `LocaleCubit` starts with English before loading a persisted
  choice; supported locales come from `AppLocalizations.supportedLocales`.

Use the IDE or your image tool to replace the existing native icon and launch
image assets. No project generator or automatic identifier-renaming tool is
provided.

## 5. Add game assets

Place game images under `assets/`, grouped by game as useful, and put audio in
Flame's default `assets/audio/` tree. `AudioService` passes file names to
FlameAudio, which uses the audio cache prefix. Register the directories in
`pubspec.yaml` under `flutter: assets:`:

```yaml
flutter:
  assets:
    - assets/my_game/images/
    - assets/audio/bgm/
    - assets/audio/sfx/
```

Flame image and audio references must match the registered asset paths and
Flame's asset prefix behavior. Keep audio under `assets/audio/` for the default
AudioService behavior, or configure Flame's audio cache prefix before using a
different layout. Existing Demo Collector sound calls are optional and the
referenced sound files are not included. Add your licensed files and register
them, or remove/replace those calls in your own game.

## 6. Choose optional integrations

- **Ads:** disabled by default. Run with
  `--dart-define=ENABLE_ADS=true` to initialize AdMob and use Google's test ad
  unit IDs in debug/profile builds. Release builds require the platform's
  `BANNER_AD_ID_*`, `INTERSTITIAL_AD_ID_*`, and `REWARDED_AD_ID_*` values;
  missing IDs disable initialization/requests and produce a diagnostic.
  Replace the sample AdMob App IDs in Android's manifest and iOS `Info.plist`
  before a release that uses ads. Test IDs are not production configuration.
- **Firebase telemetry:** disabled by default. Configure the native Firebase
  app for Android and/or iOS, then pass `--dart-define=ENABLE_TELEMETRY=true`.
  If Firebase initialization fails, the configured fallback returns no-op
  analytics and crash reporting. Firebase collection has privacy and store
  disclosure implications; review the feature guide and your actual game's
  data practices.
- **Audio:** inject `AudioService` as above, add licensed assets, and use
  `playSfx`, `playBgm`, and the settings toggles. Missing optional sounds are
  safely ignored by the shared audio boundary.
- **Localization:** edit the ARB files in `lib/l10n/`. `lib/app/app.dart`
  exposes the generated supported locales; update that list and the locale
  selector in `lib/core/localization/locale_cubit.dart` when adding a language.
- **Storage:** the settings and best-score foundation uses SharedPreferences,
  suitable for small offline settings and values. It is not synchronized or
  tamper-resistant storage.

Compliance screens and the default compliance values are developer checklist
examples. They are not legal advice, final policy text, or proof of store
compliance. Configure them against the shipped game's audience, regions,
permissions, SDKs, ads, and data collection, and complete the relevant store
forms yourself.

## 7. Android release signing

Debug builds do not need release credentials. Android release signing,
iOS signing, and platform release checks are covered in the canonical
[release preparation guide](release-preparation.md). A successful debug build
does not verify a signed release artifact or App Store submission.
