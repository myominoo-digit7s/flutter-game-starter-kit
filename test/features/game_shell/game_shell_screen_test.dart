import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/ads/interstitial_ad_manager.dart';
import 'package:flutter_game_starter_kit/core/analytics/analytics_config.dart';
import 'package:flutter_game_starter_kit/core/analytics/noop_analytics_service.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';
import 'package:flutter_game_starter_kit/core/crash_reporting/crash_reporting_config.dart';
import 'package:flutter_game_starter_kit/core/crash_reporting/noop_crash_reporting_service.dart';
import 'package:flutter_game_starter_kit/core/game/base_flame_game.dart';
import 'package:flutter_game_starter_kit/core/game/game_status.dart';
import 'package:flutter_game_starter_kit/core/telemetry/telemetry_service.dart';
import 'package:flutter_game_starter_kit/features/game_shell/game_shell_screen.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';

class _ReplacementGame extends BaseFlameGame {
  _ReplacementGame({required super.audioService, super.analyticsService})
    : super(gameId: 'replacement_game', gameName: 'Replacement Game');
}

void main() {
  testWidgets('game shell hosts a factory-provided replacement game', (
    tester,
  ) async {
    BaseFlameGame? createdGame;
    final audioService = AudioService(soundEffectPlayer: (_) async {});
    final telemetry = TelemetryService(
      analytics: NoopAnalyticsService(config: const AnalyticsConfig()),
      crashReporting: NoopCrashReportingService(
        config: const CrashReportingConfig(),
      ),
    );

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AudioService>.value(value: audioService),
          RepositoryProvider<TelemetryService>.value(value: telemetry),
          RepositoryProvider<InterstitialAdManager>.value(
            value: InterstitialAdManager(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: GameShellScreen(
            gameFactory: (audio, analytics) => createdGame = _ReplacementGame(
              audioService: audio,
              analyticsService: analytics,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(createdGame, isA<_ReplacementGame>());
    expect(find.byType(GameWidget<BaseFlameGame>), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsOneWidget);

    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();

    expect(createdGame!.status, GameStatus.paused);
    expect(find.text('Resume'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(find.byType(GameWidget<BaseFlameGame>), findsNothing);
  });
}
