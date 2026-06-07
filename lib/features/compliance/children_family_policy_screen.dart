import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/compliance/compliance_cubit.dart';
import 'widgets/compliance_checklist_tile.dart';
import 'widgets/compliance_warning_box.dart';

class ChildrenFamilyPolicyScreen extends StatelessWidget {
  const ChildrenFamilyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Children & Family Policy')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          final config = state.config;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Current Config',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: const Text('Kids Targeted'),
                trailing: Text(
                  config.isKidsTargeted ? 'Yes' : 'No',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              ListTile(
                title: const Text('Includes Children in Audience'),
                trailing: Text(
                  config.includesChildrenInAudience ? 'Yes' : 'No',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              if (config.isKidsTargeted)
                const ComplianceWarningBox(
                  message:
                      'This app is configured as targeted primarily at kids. You must use only certified ad networks and comply strictly with COPPA/GDPR-K policies. Do not collect sensitive data (location, email) without parental consent.',
                ),
              const ComplianceWarningBox(
                message:
                    'Child/family compliance depends on locale, age group, final content, SDKs, and store declarations. Legal review is strongly recommended.',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Preparation Checklist',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ...state.childrenFamilyItems.map(
                (item) => ComplianceChecklistTile(item: item),
              ),
            ],
          );
        },
      ),
    );
  }
}
