import 'analytics_event.dart';

abstract class AnalyticsService {
  Future<void> initialize();

  Future<void> logEvent(AnalyticsEvent event);

  Future<void> logAppOpen();

  Future<void> logSessionStart({
    required String sessionId,
  });

  Future<void> logSessionEnd({
    required String sessionId,
    required Duration duration,
  });

  Future<void> logGameStart({
    required String gameId,
    required String gameName,
    int? levelNumber,
  });

  Future<void> logGameOver({
    required String gameId,
    required String gameName,
    required int score,
    required int bestScore,
    required Duration duration,
    required bool isNewBestScore,
    String? reason,
  });

  Future<void> logLevelStart({
    required String gameId,
    required int levelNumber,
  });

  Future<void> logLevelComplete({
    required String gameId,
    required int levelNumber,
    required int score,
    required Duration duration,
  });

  Future<void> logLevelFailed({
    required String gameId,
    required int levelNumber,
    required int score,
    required String reason,
  });

  Future<void> logRewardedAdShown({
    required String placement,
    String? rewardType,
  });

  Future<void> logRewardedAdCompleted({
    required String placement,
    required String rewardType,
    int? rewardAmount,
  });

  Future<void> logRewardedAdFailed({
    required String placement,
    String? errorCode,
    String? errorMessage,
  });

  Future<void> logInterstitialShown({
    required String placement,
  });

  Future<void> logInterstitialFailed({
    required String placement,
    String? errorCode,
    String? errorMessage,
  });

  Future<void> logAdImpression({
    required String adType,
    required String placement,
  });

  Future<void> logCoinEarned({
    required int coins,
    required String source,
  });

  Future<void> logCoinSpent({
    required int coins,
    required String source,
  });

  Future<void> logSkinUnlocked({
    required String skinId,
    String? unlockMethod,
  });

  Future<void> logSettingsChanged({
    required String settingName,
    required Object settingValue,
  });

  Future<void> setAnalyticsCollectionEnabled(bool enabled);
}
