import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/compliance/compliance_cubit.dart';
import 'widgets/compliance_checklist_tile.dart';
import 'widgets/compliance_warning_box.dart';

class AdsDisclosureScreen extends StatelessWidget {
  const AdsDisclosureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ads Disclosure')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          final config = state.config;

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ad Configuration:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: const Text('Has Ads'),
                trailing: Text(
                  config.hasAds ? 'Yes' : 'No',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              ListTile(
                title: const Text('Uses AdMob'),
                trailing: Text(
                  config.usesAdMob ? 'Yes' : 'No',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              if (config.hasAds) ...[
                if (config.isKidsTargeted || config.includesChildrenInAudience)
                  const ComplianceWarningBox(
                    message:
                        'Kids-targeted or mixed-audience apps MUST configure child-directed treatment (COPPA/GDPR-K) for ad networks and use only family-compliant ad SDKs.',
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Ad Explanations',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const ListTile(
                  title: Text('Banner Ads'),
                  subtitle: Text(
                    'Small rectangular ads displayed at the top or bottom of the screen. Must not cover game controls.',
                  ),
                ),
                const ListTile(
                  title: Text('Interstitial Ads'),
                  subtitle: Text(
                    'Full-screen ads. Must only be shown at natural breaks in gameplay (e.g., Game Over, level completion).',
                  ),
                ),
                const ListTile(
                  title: Text('Rewarded Ads'),
                  subtitle: Text(
                    'Ads the user chooses to watch in exchange for an in-game reward. Must be strictly optional.',
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Checklist',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ...state.adsDisclosureItems.map(
                  (item) => ComplianceChecklistTile(item: item),
                ),
              ] else
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'This app is configured without ads. No disclosures are required.',
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
