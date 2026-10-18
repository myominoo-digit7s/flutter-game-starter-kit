# Compliance & Policy Readiness Module

## Overview
This module provides a reusable foundation for managing your game's store compliance, privacy policies, terms of service, and app store data declarations.

## Why it exists
Store policies change frequently. Missing a Data Safety declaration or failing to provide a clear Privacy Policy can result in your app being rejected or removed from Google Play or the App Store. This module centralizes your compliance checks.

## What it does
- Provides in-app UI checklists for developers to prepare for store submission.
- Generates placeholder Privacy Policy and Terms of Service documents.
- Warns about specific policies regarding AdMob, Analytics, and Children's apps.

## What it does NOT do
- It does **not** provide legal advice.
- It does **not** automatically configure your Google Play Console or App Store Connect.

## Legal Review Disclaimer
**IMPORTANT:** The generated policies and checklists in this module are placeholders. They MUST be reviewed by your legal counsel. The app owner assumes all liability for ensuring the final game complies with local laws (e.g., GDPR, COPPA) and store policies.

## How to Configure
Modify `defaultComplianceConfig` in `lib/core/compliance/compliance_config.dart`. The defaults describe the starter's optional ads and telemetry being disabled; set flags like `usesAdMob`, `usesAnalytics`, `isKidsTargeted`, and data collection to match the shipped game's actual behavior.

## How to Link
The UI is automatically linked from the Settings screen via the "Privacy & Compliance" button, routing to `/compliance`.

## Detailed guides

- [Privacy policy](privacy-policy.md) — starter policy placeholder and review
  notes.
- [Data safety and app privacy](data-safety.md) — separate Google Play and
  Apple declaration guidance.
- [Content ratings](content-rating.md) — Google Play IARC and Apple's
  App Store Connect age-rating processes.
- [Children and family policy](children-family-policy.md) — audience review
  and platform-specific considerations.
- [Ads disclosure](ads-disclosure.md) — store declarations and ad placement.
- [Terms of service](terms-of-service.md) — terms placeholders and optional
  topics to review.

## Release checklist

1. Review `ComplianceConfig` against the finished game's behavior.
2. Finalize and publish game-specific privacy and terms text where needed.
3. Complete each platform's current privacy, data safety, audience, and
   content-rating forms using the actual integrations and SDK behavior.
4. Recheck platform guidance when the app, SDKs, or policies change.
