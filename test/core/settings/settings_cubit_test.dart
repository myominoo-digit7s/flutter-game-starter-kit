import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_game_starter_kit/core/storage/shared_preferences_storage_service.dart';
import 'package:flutter_game_starter_kit/core/settings/settings_repository.dart';
import 'package:flutter_game_starter_kit/core/settings/settings_cubit.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';
import 'package:mocktail/mocktail.dart';

class MockAudioService extends Mock implements AudioService {}

void main() {
  group('SettingsCubit', () {
    late SettingsCubit settingsCubit;
    late SettingsRepository settingsRepository;
    late MockAudioService mockAudioService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final storageService = SharedPreferencesStorageService(prefs);
      settingsRepository = SettingsRepository(storageService);
      mockAudioService = MockAudioService();
      when(
        () => mockAudioService.updateSettings(
          soundEnabled: any(named: 'soundEnabled'),
          musicEnabled: any(named: 'musicEnabled'),
        ),
      ).thenReturn(null);

      settingsCubit = SettingsCubit(settingsRepository, mockAudioService)
        ..loadSettings();
    });

    test('loads default settings', () {
      expect(settingsCubit.state.soundEnabled, true);
      expect(settingsCubit.state.musicEnabled, true);
      expect(settingsCubit.state.vibrationEnabled, true);
    });

    test('toggles sound and persists', () async {
      await settingsCubit.toggleSound(false);
      expect(settingsCubit.state.soundEnabled, false);

      final loadedSettings = settingsRepository.loadSettings();
      expect(loadedSettings.soundEnabled, false);
    });

    test('toggles music and persists', () async {
      await settingsCubit.toggleMusic(false);
      expect(settingsCubit.state.musicEnabled, false);

      final loadedSettings = settingsRepository.loadSettings();
      expect(loadedSettings.musicEnabled, false);
    });

    test('toggles vibration and persists', () async {
      await settingsCubit.toggleVibration(false);
      expect(settingsCubit.state.vibrationEnabled, false);

      final loadedSettings = settingsRepository.loadSettings();
      expect(loadedSettings.vibrationEnabled, false);
    });
  });
}
