import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/features/compliance/privacy_policy_screen.dart';

void main() {
  testWidgets('PrivacyPolicyScreen shows basic elements', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final cubit = ComplianceCubit(repository: ComplianceRepository());
    cubit.load();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const PrivacyPolicyScreen(),
        ),
      ),
    );

    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.textContaining('This is a placeholder policy'), findsOneWidget);
    expect(find.text('Checklist'), findsOneWidget);
    
    // Markdown View Content Test
    expect(find.textContaining('support@example.com'), findsOneWidget);
  });
}
