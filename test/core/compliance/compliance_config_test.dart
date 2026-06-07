import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_config.dart';

void main() {
  group('ComplianceConfig', () {
    test('default config has expected values', () {
      final config = defaultComplianceConfig;
      expect(config.appName, 'Game Starter Kit');
      expect(config.hasAds, true);
      expect(config.isKidsTargeted, false);
      expect(config.usesAnalytics, false);
    });

    test('copyWith updates values correctly', () {
      final updated = defaultComplianceConfig.copyWith(
        appName: 'Test Game',
        hasAds: false,
        isKidsTargeted: true,
      );

      expect(updated.appName, 'Test Game');
      expect(updated.hasAds, false);
      expect(updated.isKidsTargeted, true);
      
      // Unchanged values should remain
      expect(updated.companyName, 'Your Company Name');
    });

    test('equality works', () {
      final config1 = defaultComplianceConfig.copyWith(appName: 'Same');
      final config2 = defaultComplianceConfig.copyWith(appName: 'Same');
      expect(config1, equals(config2));
    });
  });
}
