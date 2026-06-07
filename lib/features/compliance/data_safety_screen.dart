import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/compliance/compliance_cubit.dart';
import 'widgets/compliance_checklist_tile.dart';
import 'widgets/compliance_warning_box.dart';

class DataSafetyScreen extends StatelessWidget {
  const DataSafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Safety')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const ComplianceWarningBox(
                message:
                    'Data Safety declarations must match the actual SDKs, permissions, and data practices of the final app. Incorrect declarations can lead to app removal.',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Preparation Checklist',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              ...state.dataSafetyItems.map(
                (item) => ComplianceChecklistTile(item: item),
              ),
            ],
          );
        },
      ),
    );
  }
}
