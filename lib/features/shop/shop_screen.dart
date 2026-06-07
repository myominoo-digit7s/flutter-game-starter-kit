import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shop),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Text(l10n.shop), // Using same localized string for placeholder
      ),
    );
  }
}
