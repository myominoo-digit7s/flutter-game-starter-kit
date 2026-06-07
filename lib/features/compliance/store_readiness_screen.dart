import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/compliance/compliance_cubit.dart';
import 'widgets/compliance_checklist_tile.dart';

class StoreReadinessScreen extends StatelessWidget {
  const StoreReadinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Store Readiness')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Final Checklist',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              ...state.storeReadinessItems.map(
                (item) => ComplianceChecklistTile(item: item),
              ),
            ],
          );
        },
      ),
    );
  }
}
