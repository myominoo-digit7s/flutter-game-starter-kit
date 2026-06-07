import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../utils/app_logger.dart';

class AdService {
  Future<void> initialize() async {
    try {
      await MobileAds.instance.initialize();
      AppLogger.log('AdMob Initialized');
    } catch (e) {
      AppLogger.error('Failed to initialize AdMob: $e');
    }
  }
}
