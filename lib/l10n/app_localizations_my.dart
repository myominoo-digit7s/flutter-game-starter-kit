// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'ဖလက်တာ ဂိမ်း';

  @override
  String get play => 'ကစားရန်';

  @override
  String get settings => 'ဆက်တင်များ';

  @override
  String get shop => 'ဈေးဝယ်';

  @override
  String get leaderboard => 'အမှတ်စာရင်း';

  @override
  String get sound => 'အသံ';

  @override
  String get music => 'ဂီတ';

  @override
  String get vibration => 'တုန်ခါမှု';

  @override
  String get language => 'ဘာသာစကား';

  @override
  String get paused => 'ခေတ္တရပ်ထားသည်';

  @override
  String get resume => 'ပြန်စရန်';

  @override
  String get quit => 'ထွက်မည်';

  @override
  String get gameOver => 'ဂိမ်းပြီးဆုံးပါပြီ';

  @override
  String score(int score) {
    return 'ရမှတ်: $score';
  }

  @override
  String get playAgain => 'ထပ်ကစားမည်';

  @override
  String get menu => 'မီနူး';
}
