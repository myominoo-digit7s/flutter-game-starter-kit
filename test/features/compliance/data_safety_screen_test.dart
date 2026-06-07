import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/features/compliance/data_safety_screen.dart';

void main() {
  testWidgets('DataSafetyScreen shows Data Safety checklist', (tester) async {
    final cubit = ComplianceCubit(repository: ComplianceRepository());
    cubit.load();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const DataSafetyScreen(),
        ),
      ),
    );

    expect(find.text('Data Safety'), findsOneWidget);
    expect(find.textContaining('Data Safety declarations must match'), findsOneWidget);
    expect(find.text('Preparation Checklist'), findsOneWidget);
  });
}
