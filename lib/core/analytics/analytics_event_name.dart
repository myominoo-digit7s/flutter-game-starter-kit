class AnalyticsEventName {
  AnalyticsEventName._();

  // Game events
  static const String gameStart = 'game_start';
  static const String gameOver = 'game_over';
  static const String levelStart = 'level_start';
  static const String levelComplete = 'level_complete';
  static const String levelFailed = 'level_failed';
  static const String pauseGame = 'pause_game';
  static const String resumeGame = 'resume_game';
  static const String restartGame = 'restart_game';

  // Ad events
  static const String rewardedAdShown = 'rewarded_ad_shown';
  static const String rewardedAdCompleted = 'rewarded_ad_completed';
  static const String rewardedAdFailed = 'rewarded_ad_failed';
  static const String rewardedAdSkipped = 'rewarded_ad_skipped';
  static const String interstitialShown = 'interstitial_shown';
  static const String interstitialFailed = 'interstitial_failed';
  static const String bannerAdLoaded = 'banner_ad_loaded';
  static const String bannerAdFailed = 'banner_ad_failed';
  static const String adImpression = 'ad_impression';

  // Economy events
  static const String coinEarned = 'coin_earned';
  static const String coinSpent = 'coin_spent';
  static const String skinUnlocked = 'skin_unlocked';

  // Settings events
  static const String settingsChanged = 'settings_changed';
  static const String languageChanged = 'language_changed';
  static const String soundChanged = 'sound_changed';
  static const String musicChanged = 'music_changed';
  static const String vibrationChanged = 'vibration_changed';

  // Retention/session events
  static const String appOpen = 'app_open';
  static const String sessionStart = 'session_start';
  static const String sessionEnd = 'session_end';
  static const String dailyRewardClaimed = 'daily_reward_claimed';
}
