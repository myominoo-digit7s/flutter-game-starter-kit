# Ads Disclosure Guide

## Banner, Interstitial, and Rewarded Disclosures
- Make sure to check "Contains Ads" in your store console.
- Do not place banner ads over interactive game elements.
- Do not place interstitial ads unexpectedly during active gameplay; only at natural transitions.
- Rewarded ads must clearly describe what the reward is and must be optional.

## Test vs Production Ad IDs
Always use Test Ad IDs during development. Ensure production IDs are only loaded in release builds.

## Kids/Family Ads Warning
If your game targets children, you must use ad networks that comply with Google Play's Families Policy and COPPA/GDPR-K. You must configure the ad requests for child-directed treatment (e.g., `tagForChildDirectedTreatment`).
