import 'compliance_check_item.dart';
import 'compliance_config.dart';


class ComplianceRepository {
  List<ComplianceCheckItem> getPrivacyPolicyChecklist(ComplianceConfig config) {
    final items = [
      ComplianceCheckItem(
        id: 'pp_1',
        title: 'Include required sections',
        description: 'Ensure Introduction, Information We Collect, How We Use Information, and Contact Us are present.',
      ),
      ComplianceCheckItem(
        id: 'pp_2',
        title: 'Hosted publicly',
        description: 'The privacy policy must be hosted publicly on an active URL.',
      ),
    ];

    if (config.hasAds) {
      items.add(ComplianceCheckItem(
        id: 'pp_ads',
        title: 'Advertising section',
        description: 'Disclose third-party advertising partners and data they may collect.',
      ));
    }
    
    if (config.usesAnalytics || config.usesCrashReporting) {
      items.add(ComplianceCheckItem(
        id: 'pp_analytics',
        title: 'Analytics/Crash Reporting section',
        description: 'Disclose third-party analytics and crash reporting data collection.',
      ));
    }

    if (config.includesChildrenInAudience || config.isKidsTargeted) {
      items.add(ComplianceCheckItem(
        id: 'pp_kids',
        title: "Children's Privacy section",
        description: 'Explicitly describe data collection practices regarding children under COPPA/GDPR-K.',
      ));
    }

    return items;
  }

  List<ComplianceCheckItem> getTermsChecklist(ComplianceConfig config) {
    final items = [
      ComplianceCheckItem(
        id: 'tos_1',
        title: 'Acceptance of Terms',
        description: 'Users must agree to terms to use the app.',
      ),
      ComplianceCheckItem(
        id: 'tos_2',
        title: 'User Responsibilities',
        description: 'Define acceptable use and prohibited behaviors.',
      ),
    ];

    if (config.hasAds) {
      items.add(ComplianceCheckItem(
        id: 'tos_ads',
        title: 'Ads and Rewards',
        description: 'Clarify terms around watching ads and earning rewards, stating rewards have no real-world value.',
      ));
    }

    return items;
  }

  List<ComplianceCheckItem> getDataSafetyChecklist(ComplianceConfig config) {
    final items = [
      ComplianceCheckItem(
        id: 'ds_sdks',
        title: 'Confirm SDKs',
        description: 'Review all imported SDKs (e.g. Flutter, Firebase) to declare their data collection.',
      ),
      ComplianceCheckItem(
        id: 'ds_policy',
        title: 'Privacy Policy Match',
        description: 'Ensure Play Console Data Safety declarations perfectly match the actual Privacy Policy text.',
      ),
    ];

    if (config.collectsDeviceIdentifiers) {
      items.add(ComplianceCheckItem(
        id: 'ds_device_ids',
        title: 'Device Identifiers',
        description: 'Declare Device/Other IDs collection in Data Safety.',
      ));
    }

    if (config.collectsApproximateLocation || config.collectsPreciseLocation) {
      items.add(ComplianceCheckItem(
        id: 'ds_location',
        title: 'Location Data',
        description: 'Declare Location data collection in Data Safety.',
      ));
    }

    if (config.supportsAccountCreation) {
      items.add(ComplianceCheckItem(
        id: 'ds_account',
        title: 'Account Deletion',
        description: 'Provide an accessible URL where users can request account and data deletion.',
      ));
    }

    return items;
  }

  List<ComplianceCheckItem> getContentRatingChecklist(ComplianceConfig config) {
    return [
      ComplianceCheckItem(
        id: 'cr_violence',
        title: 'Violence/Scary Content',
        description: 'Accurately report any cartoon or realistic violence.',
      ),
      ComplianceCheckItem(
        id: 'cr_gambling',
        title: 'Gambling',
        description: 'Accurately report any simulated gambling or real gambling mechanics.',
      ),
      if (config.supportsUserGeneratedContent)
        ComplianceCheckItem(
          id: 'cr_ugc',
          title: 'User-Generated Content',
          description: 'Declare UGC and provide mechanisms for reporting/moderating content.',
        ),
      if (config.collectsPreciseLocation)
        ComplianceCheckItem(
          id: 'cr_location',
          title: 'Location Sharing',
          description: 'Accurately report precise location sharing capabilities.',
        ),
    ];
  }

  List<ComplianceCheckItem> getAdsDisclosureChecklist(ComplianceConfig config) {
    if (!config.hasAds) return [];

    final items = [
      ComplianceCheckItem(
        id: 'ad_1',
        title: 'Contains Ads Label',
        description: 'Ensure the store listing is marked as "Contains Ads".',
      ),
      ComplianceCheckItem(
        id: 'ad_2',
        title: 'Test IDs during Dev',
        description: 'Verify only test ad IDs are used during development.',
      ),
      ComplianceCheckItem(
        id: 'ad_3',
        title: 'Interstitial Ad Placement',
        description: 'Ensure interstitial ads only show at natural transition points (e.g. between levels).',
      ),
      ComplianceCheckItem(
        id: 'ad_4',
        title: 'Banner Ad Placement',
        description: 'Ensure banner ads do not overlap with game controls or interactive elements.',
      ),
    ];

    if (config.isKidsTargeted || config.includesChildrenInAudience) {
      items.add(ComplianceCheckItem(
        id: 'ad_kids',
        title: 'Family-compliant Ad Networks',
        description: 'Verify ad networks are certified for families and child-directed treatment is enabled where necessary.',
      ));
    }

    return items;
  }

  List<ComplianceCheckItem> getChildrenFamilyChecklist(ComplianceConfig config) {
    final items = [
      ComplianceCheckItem(
        id: 'fam_1',
        title: 'Target Age Group',
        description: "Confirm the official target age group accurately reflects the game's appeal and content.",
      ),
    ];

    if (config.isKidsTargeted || config.includesChildrenInAudience) {
      items.add(ComplianceCheckItem(
        id: 'fam_data',
        title: 'Data Collection Limitations',
        description: 'Ensure no prohibited personal info (e.g. location, email without consent) is collected from children.',
      ));
      if (config.hasAds) {
        items.add(ComplianceCheckItem(
          id: 'fam_ads',
          title: 'Personalized Ads Disabled',
          description: 'Disable personalized ads / remarketing for users under the age of consent.',
        ));
      }
      if (config.allowsExternalLinks) {
        items.add(ComplianceCheckItem(
          id: 'fam_links',
          title: 'External Links Parental Gate',
          description: 'Use a parental gate (e.g. a math problem) before opening external URLs or social media.',
        ));
      }
    }

    return items;
  }

  List<ComplianceCheckItem> getStoreReadinessChecklist(ComplianceConfig config) {
    return [
      ComplianceCheckItem(
        id: 'sr_privacy',
        title: 'Privacy Policy URL',
        description: 'Added to store listing.',
      ),
      ComplianceCheckItem(
        id: 'sr_terms',
        title: 'Terms of Service URL',
        description: 'Added to store listing or website.',
      ),
      ComplianceCheckItem(
        id: 'sr_data_safety',
        title: 'Data Safety Submitted',
        description: 'Completed in Play Console.',
      ),
      ComplianceCheckItem(
        id: 'sr_content_rating',
        title: 'Content Rating Completed',
        description: 'Questionnaire finished in store console.',
      ),
      if (config.hasAds)
        ComplianceCheckItem(
          id: 'sr_ads',
          title: 'Ads Disclosed',
          description: 'App marked as Contains Ads.',
        ),
      ComplianceCheckItem(
        id: 'sr_target_audience',
        title: 'Target Audience Submitted',
        description: 'Children/Family status correctly declared.',
      ),
    ];
  }
}
