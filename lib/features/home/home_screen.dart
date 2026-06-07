import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';

import '../../core/ads/ad_placement.dart';
import '../../core/ads/widgets/banner_ad_widget.dart';
import '../../app/router/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.game),
                    child: Text(l10n.play),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.settings),
                    child: Text(l10n.settings),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.shop),
                    child: Text(l10n.shop),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.leaderboard),
                    child: Text(l10n.leaderboard),
                  ),
                ],
              ),
            ),
          ),
          const BannerAdWidget(placement: AdPlacement.homeScreen),
        ],
      ),
    );
  }
}
