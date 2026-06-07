import '../storage/local_storage_service.dart';
import '../storage/storage_keys.dart';
import 'settings_state.dart';

class SettingsRepository {
  final LocalStorageService _storageService;

  SettingsRepository(this._storageService);

  SettingsState loadSettings() {
    final soundEnabled =
        _storageService.getBool(StorageKeys.soundEnabled) ?? true;
    final musicEnabled =
        _storageService.getBool(StorageKeys.musicEnabled) ?? true;
    final vibrationEnabled =
        _storageService.getBool(StorageKeys.vibrationEnabled) ?? true;

    return SettingsState(
      soundEnabled: soundEnabled,
      musicEnabled: musicEnabled,
      vibrationEnabled: vibrationEnabled,
    );
  }

  String loadSelectedLocale() {
    return _storageService.getString(StorageKeys.selectedLocale) ?? 'en';
  }

  Future<void> saveSoundEnabled(bool value) async {
    await _storageService.setBool(StorageKeys.soundEnabled, value);
  }

  Future<void> saveMusicEnabled(bool value) async {
    await _storageService.setBool(StorageKeys.musicEnabled, value);
  }

  Future<void> saveVibrationEnabled(bool value) async {
    await _storageService.setBool(StorageKeys.vibrationEnabled, value);
  }

  Future<void> saveSelectedLocale(String value) async {
    await _storageService.setString(StorageKeys.selectedLocale, value);
  }
}
