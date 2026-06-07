import 'package:flutter_bloc/flutter_bloc.dart';

import '../audio/audio_service.dart';
import '../analytics/analytics_service.dart';
import '../analytics/analytics_event_name.dart';
import 'settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;
  final AudioService _audioService;
  final AnalyticsService? _analytics;

  SettingsCubit(this._repository, this._audioService, [this._analytics])
    : super(const SettingsState());

  void loadSettings() {
    final settings = _repository.loadSettings();
    _audioService.updateSettings(
      soundEnabled: settings.soundEnabled,
      musicEnabled: settings.musicEnabled,
    );
    // We recreate SettingsState based on what was loaded,
    // note that selectedLocale is handled by LocaleCubit now
    emit(
      SettingsState(
        soundEnabled: settings.soundEnabled,
        musicEnabled: settings.musicEnabled,
        vibrationEnabled: settings.vibrationEnabled,
      ),
    );
  }

  Future<void> toggleSound(bool value) async {
    await _repository.saveSoundEnabled(value);
    _audioService.updateSettings(
      soundEnabled: value,
      musicEnabled: state.musicEnabled,
    );
    _analytics?.logSettingsChanged(settingName: AnalyticsEventName.soundChanged, settingValue: value);
    emit(state.copyWith(soundEnabled: value));
  }

  Future<void> toggleMusic(bool value) async {
    await _repository.saveMusicEnabled(value);
    _audioService.updateSettings(
      soundEnabled: state.soundEnabled,
      musicEnabled: value,
    );
    _analytics?.logSettingsChanged(settingName: AnalyticsEventName.musicChanged, settingValue: value);
    emit(state.copyWith(musicEnabled: value));
  }

  Future<void> toggleVibration(bool value) async {
    await _repository.saveVibrationEnabled(value);
    _analytics?.logSettingsChanged(settingName: AnalyticsEventName.vibrationChanged, settingValue: value);
    emit(state.copyWith(vibrationEnabled: value));
  }
}
