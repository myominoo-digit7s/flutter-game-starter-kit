import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_game_starter_kit/features/settings/settings_screen.dart';
import 'package:flutter_game_starter_kit/core/settings/settings_cubit.dart';
import 'package:flutter_game_starter_kit/core/localization/locale_cubit.dart';
import 'package:flutter_game_starter_kit/core/settings/settings_repository.dart';
import 'package:flutter_game_starter_kit/core/storage/shared_preferences_storage_service.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';

class MockAudioService extends Mock implements AudioService {}

void main() {
  late SettingsCubit settingsCubit;
  late LocaleCubit localeCubit;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final storageService = SharedPreferencesStorageService(prefs);
    final settingsRepository = SettingsRepository(storageService);

    final mockAudioService = MockAudioService();
    when(
      () => mockAudioService.updateSettings(
        soundEnabled: any(named: 'soundEnabled'),
        musicEnabled: any(named: 'musicEnabled'),
      ),
    ).thenReturn(null);

    settingsCubit = SettingsCubit(settingsRepository, mockAudioService)
      ..loadSettings();
    localeCubit = LocaleCubit(settingsRepository)..loadLocale();
  });

  testWidgets('SettingsScreen shows toggles', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>.value(value: settingsCubit),
          BlocProvider<LocaleCubit>.value(value: localeCubit),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsScreen(),
        ),
      ),
    );

    // Wait for cubit to load state
    await tester.pumpAndSettle();

    expect(find.text('Sound'), findsOneWidget);
    expect(find.text('Music'), findsOneWidget);
    expect(find.text('Vibration'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
  });
}
