import 'package:equatable/equatable.dart';

class ComplianceConfig extends Equatable {
  final String appName;
  final String companyName;
  final String contactEmail;
  final String privacyPolicyUrl;
  final String termsOfServiceUrl;
  final DateTime effectiveDate;

  final bool hasAds;
  final bool usesAdMob;
  final bool usesAnalytics;
  final bool usesCrashReporting;
  final bool usesInAppPurchases;

  final bool isKidsTargeted;
  final bool includesChildrenInAudience;

  final bool collectsPersonalData;
  final bool collectsDeviceIdentifiers;
  final bool collectsApproximateLocation;
  final bool collectsPreciseLocation;

  final bool supportsAccountCreation;
  final bool supportsUserGeneratedContent;
  final bool supportsPushNotifications;
  final bool allowsExternalLinks;

  const ComplianceConfig({
    required this.appName,
    required this.companyName,
    required this.contactEmail,
    required this.privacyPolicyUrl,
    required this.termsOfServiceUrl,
    required this.effectiveDate,
    required this.hasAds,
    required this.usesAdMob,
    required this.usesAnalytics,
    required this.usesCrashReporting,
    required this.usesInAppPurchases,
    required this.isKidsTargeted,
    required this.includesChildrenInAudience,
    required this.collectsPersonalData,
    required this.collectsDeviceIdentifiers,
    required this.collectsApproximateLocation,
    required this.collectsPreciseLocation,
    required this.supportsAccountCreation,
    required this.supportsUserGeneratedContent,
    required this.supportsPushNotifications,
    required this.allowsExternalLinks,
  });

  ComplianceConfig copyWith({
    String? appName,
    String? companyName,
    String? contactEmail,
    String? privacyPolicyUrl,
    String? termsOfServiceUrl,
    DateTime? effectiveDate,
    bool? hasAds,
    bool? usesAdMob,
    bool? usesAnalytics,
    bool? usesCrashReporting,
    bool? usesInAppPurchases,
    bool? isKidsTargeted,
    bool? includesChildrenInAudience,
    bool? collectsPersonalData,
    bool? collectsDeviceIdentifiers,
    bool? collectsApproximateLocation,
    bool? collectsPreciseLocation,
    bool? supportsAccountCreation,
    bool? supportsUserGeneratedContent,
    bool? supportsPushNotifications,
    bool? allowsExternalLinks,
  }) {
    return ComplianceConfig(
      appName: appName ?? this.appName,
      companyName: companyName ?? this.companyName,
      contactEmail: contactEmail ?? this.contactEmail,
      privacyPolicyUrl: privacyPolicyUrl ?? this.privacyPolicyUrl,
      termsOfServiceUrl: termsOfServiceUrl ?? this.termsOfServiceUrl,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      hasAds: hasAds ?? this.hasAds,
      usesAdMob: usesAdMob ?? this.usesAdMob,
      usesAnalytics: usesAnalytics ?? this.usesAnalytics,
      usesCrashReporting: usesCrashReporting ?? this.usesCrashReporting,
      usesInAppPurchases: usesInAppPurchases ?? this.usesInAppPurchases,
      isKidsTargeted: isKidsTargeted ?? this.isKidsTargeted,
      includesChildrenInAudience: includesChildrenInAudience ?? this.includesChildrenInAudience,
      collectsPersonalData: collectsPersonalData ?? this.collectsPersonalData,
      collectsDeviceIdentifiers: collectsDeviceIdentifiers ?? this.collectsDeviceIdentifiers,
      collectsApproximateLocation: collectsApproximateLocation ?? this.collectsApproximateLocation,
      collectsPreciseLocation: collectsPreciseLocation ?? this.collectsPreciseLocation,
      supportsAccountCreation: supportsAccountCreation ?? this.supportsAccountCreation,
      supportsUserGeneratedContent: supportsUserGeneratedContent ?? this.supportsUserGeneratedContent,
      supportsPushNotifications: supportsPushNotifications ?? this.supportsPushNotifications,
      allowsExternalLinks: allowsExternalLinks ?? this.allowsExternalLinks,
    );
  }

  @override
  List<Object?> get props => [
        appName,
        companyName,
        contactEmail,
        privacyPolicyUrl,
        termsOfServiceUrl,
        effectiveDate,
        hasAds,
        usesAdMob,
        usesAnalytics,
        usesCrashReporting,
        usesInAppPurchases,
        isKidsTargeted,
        includesChildrenInAudience,
        collectsPersonalData,
        collectsDeviceIdentifiers,
        collectsApproximateLocation,
        collectsPreciseLocation,
        supportsAccountCreation,
        supportsUserGeneratedContent,
        supportsPushNotifications,
        allowsExternalLinks,
      ];
}

final defaultComplianceConfig = ComplianceConfig(
  appName: 'Game Starter Kit',
  companyName: 'Your Company Name',
  contactEmail: 'support@example.com',
  privacyPolicyUrl: 'https://example.com/privacy-policy',
  termsOfServiceUrl: 'https://example.com/terms',
  effectiveDate: DateTime(2026, 1, 1),
  hasAds: true,
  usesAdMob: true,
  usesAnalytics: false,
  usesCrashReporting: false,
  usesInAppPurchases: false,
  isKidsTargeted: false,
  includesChildrenInAudience: false,
  collectsPersonalData: false,
  collectsDeviceIdentifiers: true,
  collectsApproximateLocation: false,
  collectsPreciseLocation: false,
  supportsAccountCreation: false,
  supportsUserGeneratedContent: false,
  supportsPushNotifications: false,
  allowsExternalLinks: true,
);
