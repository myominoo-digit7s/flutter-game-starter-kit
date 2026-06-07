import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/features/compliance/content_rating_screen.dart';

void main() {
  testWidgets('ContentRatingScreen shows checklist', (tester) async {
    final cubit = ComplianceCubit(repository: ComplianceRepository());
    cubit.load();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const ContentRatingScreen(),
        ),
      ),
    );

    expect(find.text('Content Rating'), findsOneWidget);
    expect(find.text('Preparation Checklist'), findsOneWidget);
  });
}
