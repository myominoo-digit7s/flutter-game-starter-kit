import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/features/home/home_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_game_starter_kit/l10n/app_localizations.dart';

void main() {
  testWidgets('HomeScreen shows correct elements', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify App title is shown
    expect(find.text('Flutter Game Starter Kit'), findsOneWidget);

    // Verify Play button
    expect(find.text('Play'), findsOneWidget);

    // Verify Settings button
    expect(find.text('Settings'), findsOneWidget);

    // Verify Shop button
    expect(find.text('Shop'), findsOneWidget);

    // Verify Leaderboard button
    expect(find.text('Leaderboard'), findsOneWidget);
  });
}
