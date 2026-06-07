import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_game_starter_kit/core/localization/locale_cubit.dart';
import 'package:flutter_game_starter_kit/core/settings/settings_repository.dart';
import 'package:flutter_game_starter_kit/core/storage/shared_preferences_storage_service.dart';

void main() {
  group('LocaleCubit', () {
    late LocaleCubit localeCubit;
    late SettingsRepository settingsRepository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final storageService = SharedPreferencesStorageService(prefs);
      settingsRepository = SettingsRepository(storageService);
      localeCubit = LocaleCubit(settingsRepository)..loadLocale();
    });

    test('loads default locale', () {
      expect(localeCubit.state, const Locale('en'));
    });

    test('changes locale and persists', () async {
      await localeCubit.changeLocale('my');
      expect(localeCubit.state, const Locale('my'));

      final loadedLocale = settingsRepository.loadSelectedLocale();
      expect(loadedLocale, 'my');
    });
  });
}
