import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/ads/ad_placement.dart';
import '../../core/audio/audio_service.dart';
import '../../core/telemetry/telemetry_service.dart';
import '../../core/ads/interstitial_ad_manager.dart';
import '../../core/game/game_result.dart';
import '../../games/demo_collector/demo_collector_game.dart';

class GameShellScreen extends StatefulWidget {
  const GameShellScreen({super.key});

  @override
  State<GameShellScreen> createState() => _GameShellScreenState();
}

class _GameShellScreenState extends State<GameShellScreen> {
  DemoCollectorGame? _game;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to access context after first frame,
    // or didChangeDependencies if needed.
    // We can also just read it from context inside didChangeDependencies.
  }

  void _handleGameResult(GameResult result) {
    context.read<InterstitialAdManager>().showAdIfAppropriate(AdPlacement.gameOver);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_game == null) {
      final audioService = context.read<AudioService>();
      final telemetryService = context.read<TelemetryService>();
      _game = DemoCollectorGame(
        audioService: audioService,
        analyticsService: telemetryService.analytics,
      );
      _game!.onGameResult = _handleGameResult;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _game!.startGame();
      });
      _isInitialized = true;
    }
  }

  bool _isInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: GameWidget(
        game: _game!,
        overlayBuilderMap: {
          'HUD': (context, DemoCollectorGame game) {
            return Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.pause, color: Colors.white),
                onPressed: () => game.pauseGame(),
              ),
            );
          },
          'Pause': (context, DemoCollectorGame game) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black54,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.paused,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => game.resumeGame(),
                      child: Text(l10n.resume),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.pop(),
                      child: Text(l10n.quit),
                    ),
                  ],
                ),
              ),
            );
          },
          'GameOver': (context, DemoCollectorGame game) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black87,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.gameOver,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.score(game.scoreManager.currentScore),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => game.restartGame(),
                      child: Text(l10n.playAgain),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.pop(),
                      child: Text(l10n.menu),
                    ),
                  ],
                ),
              ),
            );
          },
        },
      ),
    );
  }
}
