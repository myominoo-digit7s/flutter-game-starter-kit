import '../utils/app_logger.dart';
import 'analytics_config.dart';
import 'analytics_event.dart';
import 'analytics_service.dart';

class NoopAnalyticsService implements AnalyticsService {
  final AnalyticsConfig config;

  NoopAnalyticsService({required this.config});

  void _log(String message) {
    if (config.debugLoggingEnabled) {
      AppLogger.log('[NoopAnalytics] $message');
    }
  }

  @override
  Future<void> initialize() async {
    _log('Initialized NoopAnalyticsService');
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    if (!config.enabled) return;
    _log('Event: ${event.name} | params: ${event.sanitizedParameters}');
  }

  @override
  Future<void> logAppOpen() async {
    if (!config.collectRetentionEvents) return;
    await logEvent(AnalyticsEvent(name: 'app_open'));
  }

  @override
  Future<void> logSessionStart({required String sessionId}) async {
    if (!config.collectRetentionEvents) return;
    await logEvent(AnalyticsEvent(name: 'session_start', parameters: {'session_id': sessionId}));
  }

  @override
  Future<void> logSessionEnd({required String sessionId, required Duration duration}) async {
    if (!config.collectRetentionEvents) return;
    await logEvent(AnalyticsEvent(name: 'session_end', parameters: {
      'session_id': sessionId,
      'session_duration_seconds': duration.inSeconds,
    }));
  }

  @override
  Future<void> logGameStart({required String gameId, required String gameName, int? levelNumber}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(name: 'game_start', parameters: {
      'game_id': gameId,
      'game_name': gameName,
      'level_number': levelNumber,
    }));
  }

  @override
  Future<void> logGameOver({required String gameId, required String gameName, required int score, required int bestScore, required Duration duration, required bool isNewBestScore, String? reason}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(name: 'game_over', parameters: {
      'game_id': gameId,
      'game_name': gameName,
      'score': score,
      'best_score': bestScore,
      'duration_seconds': duration.inSeconds,
      'is_new_best_score': isNewBestScore,
      'reason': reason,
    }));
  }

  @override
  Future<void> logLevelStart({required String gameId, required int levelNumber}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(name: 'level_start', parameters: {'game_id': gameId, 'level_number': levelNumber}));
  }

  @override
  Future<void> logLevelComplete({required String gameId, required int levelNumber, required int score, required Duration duration}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(name: 'level_complete', parameters: {
      'game_id': gameId,
      'level_number': levelNumber,
      'score': score,
      'duration_seconds': duration.inSeconds,
    }));
  }

  @override
  Future<void> logLevelFailed({required String gameId, required int levelNumber, required int score, required String reason}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(name: 'level_failed', parameters: {
      'game_id': gameId,
      'level_number': levelNumber,
      'score': score,
      'reason': reason,
    }));
  }

  @override
  Future<void> logRewardedAdShown({required String placement, String? rewardType}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(name: 'rewarded_ad_shown', parameters: {'ad_placement': placement, 'reward_type': rewardType}));
  }

  @override
  Future<void> logRewardedAdCompleted({required String placement, required String rewardType, int? rewardAmount}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(name: 'rewarded_ad_completed', parameters: {
      'ad_placement': placement,
      'reward_type': rewardType,
      'reward_amount': rewardAmount,
    }));
  }

  @override
  Future<void> logRewardedAdFailed({required String placement, String? errorCode, String? errorMessage}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(name: 'rewarded_ad_failed', parameters: {
      'ad_placement': placement,
      'error_code': errorCode,
      'error_message': errorMessage,
    }));
  }

  @override
  Future<void> logInterstitialShown({required String placement}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(name: 'interstitial_shown', parameters: {'ad_placement': placement}));
  }

  @override
  Future<void> logInterstitialFailed({required String placement, String? errorCode, String? errorMessage}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(name: 'interstitial_failed', parameters: {
      'ad_placement': placement,
      'error_code': errorCode,
      'error_message': errorMessage,
    }));
  }

  @override
  Future<void> logAdImpression({required String adType, required String placement}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(name: 'ad_impression', parameters: {'ad_type': adType, 'ad_placement': placement}));
  }

  @override
  Future<void> logCoinEarned({required int coins, required String source}) async {
    if (!config.collectEconomyEvents) return;
    await logEvent(AnalyticsEvent(name: 'coin_earned', parameters: {'coins': coins, 'coin_source': source}));
  }

  @override
  Future<void> logCoinSpent({required int coins, required String source}) async {
    if (!config.collectEconomyEvents) return;
    await logEvent(AnalyticsEvent(name: 'coin_spent', parameters: {'coins': coins, 'coin_source': source}));
  }

  @override
  Future<void> logSkinUnlocked({required String skinId, String? unlockMethod}) async {
    if (!config.collectEconomyEvents) return;
    await logEvent(AnalyticsEvent(name: 'skin_unlocked', parameters: {'skin_id': skinId, 'reason': unlockMethod}));
  }

  @override
  Future<void> logSettingsChanged({required String settingName, required Object settingValue}) async {
    if (!config.collectSettingsEvents) return;
    await logEvent(AnalyticsEvent(name: 'settings_changed', parameters: {'setting_name': settingName, 'setting_value': settingValue}));
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    _log('Analytics collection enabled: $enabled');
  }
}
