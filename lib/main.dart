import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/bootstrap.dart';

void main() async {
  final (
    settingsCubit,
    localeCubit,
    audioService,
    adService,
    interstitialAdManager,
    rewardedAdManager,
    complianceCubit,
    telemetryService,
  ) = await bootstrap();
  runApp(
    App(
      settingsCubit: settingsCubit,
      localeCubit: localeCubit,
      audioService: audioService,
      adService: adService,
      interstitialAdManager: interstitialAdManager,
      rewardedAdManager: rewardedAdManager,
      complianceCubit: complianceCubit,
      telemetryService: telemetryService,
    ),
  );
}
