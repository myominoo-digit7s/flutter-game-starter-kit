# Data Safety Guide

## Checklist
The `DataSafetyScreen` generates a checklist based on your `ComplianceConfig`.

## Mapping Config to Play Console
- `usesAnalytics` / `usesCrashReporting` -> You must declare collection of Crash logs and Diagnostics.
- `collectsDeviceIdentifiers` -> You must declare Device or other IDs collection.
- `collectsApproximateLocation` -> Declare Approximate Location.
- `supportsAccountCreation` -> You must provide an account deletion URL.

## Reminder
The Play Console Data Safety section must perfectly match your actual code, SDKs, AndroidManifest permissions, and Privacy Policy. Failure to match will result in a policy strike.
