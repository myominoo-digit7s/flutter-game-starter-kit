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
Modify `defaultComplianceConfig` in `lib/core/compliance/compliance_config.dart`. Set flags like `usesAdMob`, `usesAnalytics`, `isKidsTargeted`, etc., to match your app's actual behavior.

## How to Link
The UI is automatically linked from the Settings screen via the "Privacy & Compliance" button, routing to `/compliance`.

## Release Checklist
1. Review `ComplianceConfig`.
2. Generate and finalize your Privacy Policy text.
3. Host the Privacy Policy online and update the URL.
4. Complete the Data Safety and Content Rating questionnaires on the app store console based on this module's checklists.
