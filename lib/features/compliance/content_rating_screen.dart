import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/compliance/compliance_cubit.dart';
import 'widgets/compliance_checklist_tile.dart';
import 'widgets/compliance_warning_box.dart';

class ContentRatingScreen extends StatelessWidget {
  const ContentRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Content Rating')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const ComplianceWarningBox(
                message:
                    'Answer the official content rating questionnaire honestly based on the final game content. Store algorithms may audit your app to verify this.',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Preparation Checklist',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              ...state.contentRatingItems.map(
                (item) => ComplianceChecklistTile(item: item),
              ),
            ],
          );
        },
      ),
    );
  }
}
