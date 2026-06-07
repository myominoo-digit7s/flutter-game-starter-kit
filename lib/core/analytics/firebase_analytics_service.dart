import 'package:firebase_analytics/firebase_analytics.dart';

import '../utils/app_logger.dart';
import 'analytics_config.dart';
import 'analytics_event.dart';
import 'analytics_service.dart';
import 'analytics_event_name.dart';
import 'analytics_parameter.dart';

class FirebaseAnalyticsService implements AnalyticsService {
  final AnalyticsConfig config;
  final FirebaseAnalytics _analytics;

  FirebaseAnalyticsService({
    required this.config,
    FirebaseAnalytics? analytics,
  }) : _analytics = analytics ?? FirebaseAnalytics.instance;

  void _log(String message) {
    if (config.debugLoggingEnabled) {
      AppLogger.log('[FirebaseAnalytics] $message');
    }
  }

  @override
  Future<void> initialize() async {
    _log('Initialized FirebaseAnalyticsService');
    await setAnalyticsCollectionEnabled(config.enabled);
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    if (!config.enabled) return;
    try {
      final sanitizedParams = event.sanitizedParameters;
      _log('Logging event: ${event.name} | params: $sanitizedParams');
      await _analytics.logEvent(
        name: event.name,
        parameters: sanitizedParams,
      );
    } catch (e, st) {
      AppLogger.error('Failed to log Firebase event: ${event.name}', e, st);
    }
  }

  @override
  Future<void> logAppOpen() async {
    if (!config.collectRetentionEvents) return;
    try {
      _log('Logging app_open');
      await _analytics.logAppOpen();
    } catch (e, st) {
      AppLogger.error('Failed to log app_open', e, st);
    }
  }

  @override
  Future<void> logSessionStart({required String sessionId}) async {
    if (!config.collectRetentionEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.sessionStart,
      parameters: {AnalyticsParameter.sessionId: sessionId},
    ));
  }

  @override
  Future<void> logSessionEnd({required String sessionId, required Duration duration}) async {
    if (!config.collectRetentionEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.sessionEnd,
      parameters: {
        AnalyticsParameter.sessionId: sessionId,
        AnalyticsParameter.sessionDurationSeconds: duration.inSeconds,
      },
    ));
  }

  @override
  Future<void> logGameStart({required String gameId, required String gameName, int? levelNumber}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.gameStart,
      parameters: {
        AnalyticsParameter.gameId: gameId,
        AnalyticsParameter.gameName: gameName,
        AnalyticsParameter.levelNumber: levelNumber,
      },
    ));
  }

  @override
  Future<void> logGameOver({required String gameId, required String gameName, required int score, required int bestScore, required Duration duration, required bool isNewBestScore, String? reason}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.gameOver,
      parameters: {
        AnalyticsParameter.gameId: gameId,
        AnalyticsParameter.gameName: gameName,
        AnalyticsParameter.score: score,
        AnalyticsParameter.bestScore: bestScore,
        AnalyticsParameter.durationSeconds: duration.inSeconds,
        AnalyticsParameter.isNewBestScore: isNewBestScore.toString(),
        AnalyticsParameter.reason: reason,
      },
    ));
  }

  @override
  Future<void> logLevelStart({required String gameId, required int levelNumber}) async {
    if (!config.collectGameEvents) return;
    try {
      _log('Logging level_start');
      await _analytics.logLevelStart(levelName: '$gameId-$levelNumber');
    } catch (e, st) {
      AppLogger.error('Failed to log level_start', e, st);
    }
  }

  @override
  Future<void> logLevelComplete({required String gameId, required int levelNumber, required int score, required Duration duration}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.levelComplete,
      parameters: {
        AnalyticsParameter.gameId: gameId,
        AnalyticsParameter.levelNumber: levelNumber,
        AnalyticsParameter.score: score,
        AnalyticsParameter.durationSeconds: duration.inSeconds,
      },
    ));
  }

  @override
  Future<void> logLevelFailed({required String gameId, required int levelNumber, required int score, required String reason}) async {
    if (!config.collectGameEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.levelFailed,
      parameters: {
        AnalyticsParameter.gameId: gameId,
        AnalyticsParameter.levelNumber: levelNumber,
        AnalyticsParameter.score: score,
        AnalyticsParameter.reason: reason,
      },
    ));
  }

  @override
  Future<void> logRewardedAdShown({required String placement, String? rewardType}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.rewardedAdShown,
      parameters: {
        AnalyticsParameter.adPlacement: placement,
        AnalyticsParameter.rewardType: rewardType,
      },
    ));
  }

  @override
  Future<void> logRewardedAdCompleted({required String placement, required String rewardType, int? rewardAmount}) async {
    if (!config.collectAdEvents) return;
    try {
      _log('Logging earn_virtual_currency');
      await _analytics.logEarnVirtualCurrency(
        virtualCurrencyName: rewardType,
        value: rewardAmount?.toDouble() ?? 1.0,
      );
    } catch (e, st) {
      AppLogger.error('Failed to log earn_virtual_currency', e, st);
    }
    
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.rewardedAdCompleted,
      parameters: {
        AnalyticsParameter.adPlacement: placement,
        AnalyticsParameter.rewardType: rewardType,
        AnalyticsParameter.rewardAmount: rewardAmount,
      },
    ));
  }

  @override
  Future<void> logRewardedAdFailed({required String placement, String? errorCode, String? errorMessage}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.rewardedAdFailed,
      parameters: {
        AnalyticsParameter.adPlacement: placement,
        AnalyticsParameter.errorCode: errorCode,
        AnalyticsParameter.errorMessage: errorMessage,
      },
    ));
  }

  @override
  Future<void> logInterstitialShown({required String placement}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.interstitialShown,
      parameters: {AnalyticsParameter.adPlacement: placement},
    ));
  }

  @override
  Future<void> logInterstitialFailed({required String placement, String? errorCode, String? errorMessage}) async {
    if (!config.collectAdEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.interstitialFailed,
      parameters: {
        AnalyticsParameter.adPlacement: placement,
        AnalyticsParameter.errorCode: errorCode,
        AnalyticsParameter.errorMessage: errorMessage,
      },
    ));
  }

  @override
  Future<void> logAdImpression({required String adType, required String placement}) async {
    if (!config.collectAdEvents) return;
    try {
      _log('Logging ad_impression');
      await _analytics.logAdImpression(
        adFormat: adType,
        adUnitName: placement,
      );
    } catch (e, st) {
      AppLogger.error('Failed to log ad_impression', e, st);
    }
  }

  @override
  Future<void> logCoinEarned({required int coins, required String source}) async {
    if (!config.collectEconomyEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.coinEarned,
      parameters: {
        AnalyticsParameter.coins: coins,
        AnalyticsParameter.coinSource: source,
      },
    ));
  }

  @override
  Future<void> logCoinSpent({required int coins, required String source}) async {
    if (!config.collectEconomyEvents) return;
    try {
      _log('Logging spend_virtual_currency');
      await _analytics.logSpendVirtualCurrency(
        itemName: source,
        virtualCurrencyName: 'coins',
        value: coins.toDouble(),
      );
    } catch (e, st) {
      AppLogger.error('Failed to log spend_virtual_currency', e, st);
    }
  }

  @override
  Future<void> logSkinUnlocked({required String skinId, String? unlockMethod}) async {
    if (!config.collectEconomyEvents) return;
    try {
      _log('Logging unlock_achievement');
      await _analytics.logUnlockAchievement(id: skinId);
    } catch (e, st) {
      AppLogger.error('Failed to log unlock_achievement', e, st);
    }
  }

  @override
  Future<void> logSettingsChanged({required String settingName, required Object settingValue}) async {
    if (!config.collectSettingsEvents) return;
    await logEvent(AnalyticsEvent(
      name: AnalyticsEventName.settingsChanged,
      parameters: {
        AnalyticsParameter.settingName: settingName,
        AnalyticsParameter.settingValue: settingValue.toString(),
      },
    ));
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    try {
      await _analytics.setAnalyticsCollectionEnabled(enabled);
      _log('Set Analytics Collection Enabled: $enabled');
    } catch (e, st) {
      AppLogger.error('Failed to set analytics collection enabled', e, st);
    }
  }
}
