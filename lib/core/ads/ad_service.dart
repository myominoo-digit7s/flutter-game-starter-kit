import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config/environment_config.dart';
import 'ad_unit_ids.dart';
import '../utils/app_logger.dart';

class AdService {
  final bool enabled;
  final Future<void> Function() _initializeSdk;

  AdService({
    this.enabled = EnvironmentConfig.adsEnabled,
    Future<void> Function()? initializeSdk,
  }) : _initializeSdk = initializeSdk ?? _initializeMobileAds;

  static Future<void> _initializeMobileAds() async {
    await MobileAds.instance.initialize();
  }

  Future<void> initialize() async {
    if (!enabled) return;
    if (!AdUnitIds.hasRequiredIdsForCurrentBuild) {
      debugPrint(
        'AdMob is enabled, but production ad unit IDs are missing. '
        'Skipping SDK initialization and ad requests.',
      );
      return;
    }

    try {
      await _initializeSdk();
      AppLogger.log('AdMob Initialized');
    } catch (e) {
      AppLogger.error('Failed to initialize AdMob: $e');
    }
  }
}
