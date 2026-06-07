import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_config.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';

void main() {
  group('ComplianceCubit', () {
    late ComplianceRepository repository;
    late ComplianceCubit cubit;

    setUp(() {
      repository = ComplianceRepository();
      cubit = ComplianceCubit(repository: repository);
    });

    tearDown(() {
      cubit.close();
    });

    test('load generates all checklist categories', () {
      cubit.load();
      expect(cubit.state.privacyItems.isNotEmpty, true);
      expect(cubit.state.termsItems.isNotEmpty, true);
      expect(cubit.state.dataSafetyItems.isNotEmpty, true);
      expect(cubit.state.storeReadinessItems.isNotEmpty, true);
    });

    test('kids-targeted config generates children/family warnings', () {
      cubit.updateConfig(defaultComplianceConfig.copyWith(isKidsTargeted: true));
      
      final kidsItems = cubit.state.childrenFamilyItems;
      final privacyItems = cubit.state.privacyItems;

      expect(kidsItems.any((i) => i.id == 'fam_data'), true);
      expect(privacyItems.any((i) => i.id == 'pp_kids'), true);
    });

    test('AdMob config generates ads disclosure items', () {
      cubit.updateConfig(defaultComplianceConfig.copyWith(hasAds: true));
      expect(cubit.state.adsDisclosureItems.isNotEmpty, true);
    });

    test('analytics/crash config affects data safety checklist', () {
      cubit.updateConfig(defaultComplianceConfig.copyWith(usesAnalytics: true));
      final privacyItems = cubit.state.privacyItems;
      expect(privacyItems.any((i) => i.id == 'pp_analytics'), true);
    });
    
    test('location config affects data safety checklist', () {
      cubit.updateConfig(defaultComplianceConfig.copyWith(collectsApproximateLocation: true));
      final dataSafetyItems = cubit.state.dataSafetyItems;
      expect(dataSafetyItems.any((i) => i.id == 'ds_location'), true);
    });
  });
}
