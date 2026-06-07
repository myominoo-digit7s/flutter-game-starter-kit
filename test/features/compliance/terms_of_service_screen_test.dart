import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_cubit.dart';
import 'package:flutter_game_starter_kit/core/compliance/compliance_repository.dart';
import 'package:flutter_game_starter_kit/features/compliance/terms_of_service_screen.dart';

void main() {
  testWidgets('TermsOfServiceScreen shows required elements', (tester) async {
    final cubit = ComplianceCubit(repository: ComplianceRepository());
    cubit.load();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const TermsOfServiceScreen(),
        ),
      ),
    );

    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.textContaining('Ads and Rewards'), findsOneWidget);
    expect(find.textContaining('Contact Us'), findsOneWidget);
  });
}
