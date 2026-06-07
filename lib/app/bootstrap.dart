import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/storage/local_storage_service.dart';
import '../core/storage/shared_preferences_storage_service.dart';
import '../core/ads/ad_service.dart';
import '../core/ads/interstitial_ad_manager.dart';
import '../core/ads/rewarded_ad_manager.dart';
import '../core/audio/audio_service.dart';
import '../core/localization/locale_cubit.dart';
import '../core/settings/settings_repository.dart';
import '../core/settings/settings_cubit.dart';
import '../core/compliance/compliance_cubit.dart';
import '../core/compliance/compliance_repository.dart';
import '../core/telemetry/telemetry_service.dart';
import '../core/telemetry/telemetry_config.dart';
import '../core/telemetry/telemetry_initializer.dart';
import '../core/utils/app_logger.dart';

Future<
  (
    SettingsCubit,
    LocaleCubit,
    AudioService,
    AdService,
    InterstitialAdManager,
    RewardedAdManager,
    ComplianceCubit,
    TelemetryService,
  )
>
bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.log('Initializing dependencies...');

  final sharedPreferences = await SharedPreferences.getInstance();
  final LocalStorageService storageService = SharedPreferencesStorageService(
    sharedPreferences,
  );
  final settingsRepository = SettingsRepository(storageService);

  final audioService = AudioService();
  final adService = AdService();
  await adService.initialize();

  final telemetryService = await TelemetryInitializer.initialize(
    const TelemetryConfig(),
  );

  final interstitialAdManager = InterstitialAdManager(analytics: telemetryService.analytics)..loadAd();
  final rewardedAdManager = RewardedAdManager(analytics: telemetryService.analytics)..loadAd();

  final settingsCubit = SettingsCubit(settingsRepository, audioService, telemetryService.analytics)
    ..loadSettings();
  final localeCubit = LocaleCubit(settingsRepository, telemetryService.analytics)..loadLocale();
  
  final complianceRepository = ComplianceRepository();
  final complianceCubit = ComplianceCubit(repository: complianceRepository)..load();

  return (
    settingsCubit,
    localeCubit,
    audioService,
    adService,
    interstitialAdManager,
    rewardedAdManager,
    complianceCubit,
    telemetryService,
  );
}
