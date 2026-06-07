import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';

import '../core/audio/audio_service.dart';
import '../core/ads/ad_service.dart';
import '../core/ads/interstitial_ad_manager.dart';
import '../core/ads/rewarded_ad_manager.dart';
import '../core/localization/locale_cubit.dart';
import '../core/settings/settings_cubit.dart';
import '../core/compliance/compliance_cubit.dart';
import '../core/telemetry/telemetry_service.dart';
import '../core/analytics/analytics_observer.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';
import 'observers/app_lifecycle_observer.dart';

class App extends StatefulWidget {
  final SettingsCubit settingsCubit;
  final LocaleCubit localeCubit;
  final AudioService audioService;
  final AdService adService;
  final InterstitialAdManager interstitialAdManager;
  final RewardedAdManager rewardedAdManager;
  final ComplianceCubit complianceCubit;
  final TelemetryService telemetryService;

  const App({
    super.key,
    required this.settingsCubit,
    required this.localeCubit,
    required this.audioService,
    required this.adService,
    required this.interstitialAdManager,
    required this.rewardedAdManager,
    required this.complianceCubit,
    required this.telemetryService,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _lifecycleObserver = AppLifecycleObserver();
  late final AnalyticsObserver _analyticsObserver;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
    _analyticsObserver = AnalyticsObserver(widget.telemetryService.analytics);
    widget.telemetryService.analytics.logAppOpen();
  }

  @override
  void dispose() {
    _analyticsObserver.dispose();
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.audioService),
        RepositoryProvider.value(value: widget.adService),
        RepositoryProvider.value(value: widget.interstitialAdManager),
        RepositoryProvider.value(value: widget.rewardedAdManager),
        RepositoryProvider.value(value: widget.telemetryService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>.value(value: widget.settingsCubit),
          BlocProvider<LocaleCubit>.value(value: widget.localeCubit),
          BlocProvider<ComplianceCubit>.value(value: widget.complianceCubit),
        ],
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp.router(
              title: 'Flutter Game Starter Kit',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system, // Placeholder for theme handling
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
              locale: locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
