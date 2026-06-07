# Flutter + Flame Game Starter Kit

A comprehensive, production-ready 2D Game Starter Kit using Flutter and the Flame game engine. This kit provides a solid foundation for building 2D games, featuring a robust architecture for routing, state management, persistent storage, localization, audio, and AdMob integration.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- IDE of your choice (VS Code, Android Studio, IntelliJ)

### How to Run
To run the demo game locally:
```bash
flutter pub get
flutter run
```

### How to Test
The starter kit comes with a comprehensive suite of unit and component tests.
```bash
flutter test
```
You can also run the static analyzer:
```bash
flutter analyze
```

---

## 🎮 How to Add a New Game

The starter kit uses a centralized game shell. To swap out the Demo Collector game for your own:

1. **Create a New Game Folder**
   Create a new folder in `lib/games/` for your game (e.g., `lib/games/my_awesome_game/`).
2. **Build Your Game Class**
   Create your game class extending `BaseFlameGame`.
   ```dart
   import 'package:flutter_game_starter_kit/core/game/base_flame_game.dart';

   class MyAwesomeGame extends BaseFlameGame {
     MyAwesomeGame({required super.audioService});

     @override
     Future<void> onLoad() async {
       await super.onLoad();
       // Initialize your game components
     }
   }
   ```
3. **Connect to the Shell**
   Open `lib/features/game_shell/game_shell_screen.dart` and swap out the instantiation of the game.
   ```dart
   _game = MyAwesomeGame(audioService: audioService);
   ```

*(See `docs/create-new-game-guide.md` for an in-depth guide on the core game loop, spawning, scoring, and UI overlays.)*

---

## 💰 How to Configure AdMob

The starter kit comes pre-integrated with AdMob, using Test IDs by default so you can safely run and test your app without being penalized.

To configure real AdMob for production:
1. **Update AndroidManifest.xml**
   Open `android/app/src/main/AndroidManifest.xml` and replace the test App ID with your real AdMob App ID.
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="YOUR_ADMOB_APP_ID"/>
   ```
2. **Update Info.plist (iOS)**
   Open `ios/Runner/Info.plist` and add/update the `GADApplicationIdentifier` key.
   ```xml
   <key>GADApplicationIdentifier</key>
   <string>YOUR_ADMOB_APP_ID</string>
   ```
3. **Set Production Ad Unit IDs**
   Open `lib/core/ads/ad_unit_ids.dart` and replace the test banner, interstitial, and rewarded IDs with your production IDs. Ensure you use the environment checks correctly so test IDs are used during development.

---

## 🌍 How to Add Localization

The app uses `flutter_localizations` with ARB files for multi-language support. English, Myanmar, and Thai are included out-of-the-box.

To add or modify translations:
1. Open the `lib/l10n/` directory.
2. Edit the respective `.arb` file (e.g., `app_en.arb` for English).
3. Add a new key-value pair.
   ```json
   {
     "myNewKey": "Hello World",
     "@myNewKey": {
       "description": "A welcome message"
     }
   }
   ```
4. Run the code generation:
   *(Flutter automatically generates the localizations when you build, or you can manually trigger it with `flutter gen-l10n`)*
5. Use the localized string in your UI:
   ```dart
   Text(AppLocalizations.of(context)!.myNewKey)
   ```

To add a brand new language:
1. Add a new `.arb` file (e.g., `app_es.arb` for Spanish).
2. Update the `supportedLocales` in `lib/app/app.dart`.
3. Add the language option to the `LocaleCubit` mapping in `lib/core/localization/locale_cubit.dart`.

---

## 🎵 How to Add Audio Assets

The starter kit uses `flame_audio` managed by an `AudioService` that synchronizes with the user's Settings (Sound and Music toggles).

1. Place your background music files in `assets/audio/bgm/`.
2. Place your sound effect files in `assets/audio/sfx/`.
3. Ensure your `pubspec.yaml` registers the assets directory:
   ```yaml
   flutter:
     assets:
       - assets/audio/bgm/
       - assets/audio/sfx/
   ```
4. Play audio in your game utilizing the injected `AudioService`:
   ```dart
   // Play background music
   audioService.playBgm('my_music.mp3');

   // Play a sound effect
   audioService.playSfx('jump.wav');
   ```

---

## 📚 Documentation

For deep dives into the architecture and specific features, explore the `docs/` folder:
- [Game Core Architecture](docs/features/game-core.md)
- [How to Create a New Game](docs/create-new-game-guide.md)
- [AdMob Integration](docs/features/ads.md)
- [Audio Service](docs/features/audio.md)
- [Localization](docs/features/localization.md)
- [Settings & Storage](docs/features/settings.md)
