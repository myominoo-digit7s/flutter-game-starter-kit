import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../settings/settings_repository.dart';
import '../analytics/analytics_service.dart';
import '../analytics/analytics_event_name.dart';

class LocaleCubit extends Cubit<Locale> {
  final SettingsRepository _repository;
  final AnalyticsService? _analytics;

  LocaleCubit(this._repository, [this._analytics]) : super(const Locale('en'));

  void loadLocale() {
    final locale = _repository.loadSelectedLocale();
    emit(Locale(locale));
  }

  Future<void> changeLocale(String localeCode) async {
    await _repository.saveSelectedLocale(localeCode);
    _analytics?.logSettingsChanged(settingName: AnalyticsEventName.languageChanged, settingValue: localeCode);
    emit(Locale(localeCode));
  }
}
