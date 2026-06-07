import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_config.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/features/compliance/ads_disclosure_screen.dart';

void main() {
  testWidgets('AdsDisclosureScreen shows kids warning if kids-targeted', (tester) async {
    final cubit = ComplianceCubit(
      repository: ComplianceRepository(),
      initialConfig: defaultComplianceConfig.copyWith(
        hasAds: true,
        isKidsTargeted: true,
      ),
    );
    cubit.load();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const AdsDisclosureScreen(),
        ),
      ),
    );

    expect(find.text('Ads Disclosure'), findsOneWidget);
    expect(find.textContaining('Kids-targeted or mixed-audience apps MUST configure'), findsOneWidget);
    expect(find.text('Rewarded Ads'), findsOneWidget);
  });
}
