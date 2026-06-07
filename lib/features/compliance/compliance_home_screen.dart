import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/compliance/compliance_cubit.dart';
import '../../../core/compliance/compliance_status.dart';
import 'widgets/compliance_section_card.dart';

class ComplianceHomeScreen extends StatelessWidget {
  const ComplianceHomeScreen({super.key});

  int _countReady(List items) {
    return items.where((i) => i.status == ComplianceStatus.ready).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Compliance')),
      body: BlocBuilder<ComplianceCubit, ComplianceState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              ComplianceSectionCard(
                title: 'Privacy Policy',
                description: "Review and host your game's privacy policy.",
                totalItems: state.privacyItems.length,
                completedItems: _countReady(state.privacyItems),
                onTap: () => context.pushNamed(AppRoutes.privacyPolicy),
              ),
              ComplianceSectionCard(
                title: 'Terms of Service',
                description: 'Review the rules and guidelines for your users.',
                totalItems: state.termsItems.length,
                completedItems: _countReady(state.termsItems),
                onTap: () => context.pushNamed(AppRoutes.termsOfService),
              ),
              ComplianceSectionCard(
                title: 'Data Safety',
                description:
                    'Prepare your Data Safety declarations for the store.',
                totalItems: state.dataSafetyItems.length,
                completedItems: _countReady(state.dataSafetyItems),
                onTap: () => context.pushNamed(AppRoutes.dataSafety),
              ),
              ComplianceSectionCard(
                title: 'Content Rating',
                description:
                    'Prepare for the store content rating questionnaire.',
                totalItems: state.contentRatingItems.length,
                completedItems: _countReady(state.contentRatingItems),
                onTap: () => context.pushNamed(AppRoutes.contentRating),
              ),
              if (state.config.hasAds)
                ComplianceSectionCard(
                  title: 'Ads Disclosure',
                  description:
                      'Review ad placements and disclosure requirements.',
                  totalItems: state.adsDisclosureItems.length,
                  completedItems: _countReady(state.adsDisclosureItems),
                  onTap: () => context.pushNamed(AppRoutes.adsDisclosure),
                ),
              ComplianceSectionCard(
                title: 'Children & Family Policy',
                description:
                    'Review target age group and family policy compliance.',
                totalItems: state.childrenFamilyItems.length,
                completedItems: _countReady(state.childrenFamilyItems),
                onTap: () => context.pushNamed(AppRoutes.childrenFamilyPolicy),
              ),
              ComplianceSectionCard(
                title: 'Store Readiness',
                description: 'Final checklist before submitting your game.',
                totalItems: state.storeReadinessItems.length,
                completedItems: _countReady(state.storeReadinessItems),
                onTap: () => context.pushNamed(AppRoutes.storeReadiness),
              ),
            ],
          );
        },
      ),
    );
  }
}
