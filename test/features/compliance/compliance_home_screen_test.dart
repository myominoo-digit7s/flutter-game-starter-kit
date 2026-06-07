import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/features/compliance/compliance_home_screen.dart';

void main() {
  testWidgets('ComplianceHomeScreen shows all seven compliance sections', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final cubit = ComplianceCubit(repository: ComplianceRepository());
    cubit.load();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const ComplianceHomeScreen(),
        ),
      ),
    );

    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Data Safety'), findsOneWidget);
    expect(find.text('Content Rating'), findsOneWidget);
    expect(find.text('Ads Disclosure'), findsOneWidget);
    expect(find.text('Children & Family Policy'), findsOneWidget);
    expect(find.text('Store Readiness'), findsOneWidget);
  });
}
