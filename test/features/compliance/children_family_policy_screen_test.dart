import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_config.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/features/compliance/children_family_policy_screen.dart';

void main() {
  testWidgets('ChildrenFamilyPolicyScreen shows extra warning if kids-targeted', (tester) async {
    final cubit = ComplianceCubit(
      repository: ComplianceRepository(),
      initialConfig: defaultComplianceConfig.copyWith(
        isKidsTargeted: true,
      ),
    );
    cubit.load();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const ChildrenFamilyPolicyScreen(),
        ),
      ),
    );

    expect(find.text('Children & Family Policy'), findsOneWidget);
    expect(find.text('Preparation Checklist'), findsOneWidget);
    expect(find.textContaining('This app is configured as targeted primarily at kids.'), findsOneWidget);
  });
}
