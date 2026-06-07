import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/compliance/compliance_cubit.dart';
import 'widgets/compliance_checklist_tile.dart';
import 'widgets/compliance_warning_box.dart';
import 'widgets/policy_markdown_view.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          final config = state.config;
          final markdownText =
              '''
# Terms of Service for ${config.appName}
**Effective Date:** ${config.effectiveDate.toLocal().toString().split(' ')[0]}

## Acceptance of Terms
By accessing and using ${config.appName}, you accept and agree to be bound by the terms and provision of this agreement.

## Use of the Game
You agree to use the app only for lawful purposes. You must not use the app in any way that causes damage to the app or impairment of the availability or accessibility of the app.

## Ads and Rewards
${config.hasAds ? 'The app displays advertisements. You may have the option to watch video ads in exchange for virtual in-game rewards. These rewards have no real-world monetary value and cannot be exchanged for cash.' : 'This app does not contain ads or ad-based rewards.'}

## Virtual Items / Coins
Virtual currencies or items obtained within the game have no real-world value and cannot be redeemed for real money.

## Limitation of Liability
${config.companyName} shall not be liable for any special or consequential damages that result from the use of, or the inability to use, the materials on this app or the performance of the app.

## Changes to Terms
We reserve the right, at our sole discretion, to modify or replace these Terms at any time.

## Contact Us
If you have any questions, please contact us at: ${config.contactEmail}
          ''';

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const ComplianceWarningBox(
                message:
                    'This is a placeholder document. It MUST be reviewed and approved by a legal professional.',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: PolicyMarkdownView(text: markdownText),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Checklist',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              ...state.termsItems.map(
                (item) => ComplianceChecklistTile(item: item),
              ),
            ],
          );
        },
      ),
    );
  }
}
