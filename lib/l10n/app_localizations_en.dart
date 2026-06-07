// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Game Starter Kit';

  @override
  String get play => 'Play';

  @override
  String get settings => 'Settings';

  @override
  String get shop => 'Shop';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get sound => 'Sound';

  @override
  String get music => 'Music';

  @override
  String get vibration => 'Vibration';

  @override
  String get language => 'Language';

  @override
  String get paused => 'Paused';

  @override
  String get resume => 'Resume';

  @override
  String get quit => 'Quit';

  @override
  String get gameOver => 'Game Over';

  @override
  String score(int score) {
    return 'Score: $score';
  }

  @override
  String get playAgain => 'Play Again';

  @override
  String get menu => 'Menu';
}
