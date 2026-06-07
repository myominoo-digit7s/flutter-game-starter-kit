import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/compliance/compliance_cubit.dart';
import 'widgets/compliance_checklist_tile.dart';
import 'widgets/compliance_warning_box.dart';
import 'widgets/policy_markdown_view.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          final config = state.config;
          final markdownText =
              '''
# Privacy Policy for ${config.appName}
**Effective Date:** ${config.effectiveDate.toLocal().toString().split(' ')[0]}

## Introduction
${config.companyName} ("we", "our", "us") built the ${config.appName} app. This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service.

## Information We Collect
We collect necessary information to provide and improve our Service.
- Device Identifiers: ${config.collectsDeviceIdentifiers ? 'Yes' : 'No'}
- Location Data: ${config.collectsPreciseLocation || config.collectsApproximateLocation ? 'Yes' : 'No'}
- Personal Data: ${config.collectsPersonalData ? 'Yes' : 'No'}

## How We Use Information
We use the collected data for various purposes:
- To provide and maintain the Service
- To notify you about changes to our Service
- To provide customer care and support

## Advertising
${config.hasAds ? 'We use third-party advertising companies to serve ads when you visit our app.' : 'We do not show ads in this app.'}

## Analytics and Crash Reporting
${config.usesAnalytics || config.usesCrashReporting ? 'We use third-party Service Providers to monitor and analyze the use of our Service.' : 'We do not use analytics or crash reporting.'}

## Children's Privacy
${config.isKidsTargeted || config.includesChildrenInAudience ? 'We recognize the need to provide further privacy protections with respect to personal information we may collect from children.' : 'Our Service does not address anyone under the age of 13.'}

## Contact Us
If you have any questions, please contact us at: ${config.contactEmail}
          ''';

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const ComplianceWarningBox(
                message:
                    'This is a placeholder policy. It MUST be reviewed and approved by a legal professional. The final policy must match your actual SDK usage, Data Safety declarations, and app behavior.',
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
              ...state.privacyItems.map(
                (item) => ComplianceChecklistTile(item: item),
              ),
            ],
          );
        },
      ),
    );
  }
}
