// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'เกมฟลัตเตอร์';

  @override
  String get play => 'เล่น';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get shop => 'ร้านค้า';

  @override
  String get leaderboard => 'กระดานผู้นำ';

  @override
  String get sound => 'เสียง';

  @override
  String get music => 'ดนตรี';

  @override
  String get vibration => 'การสั่น';

  @override
  String get language => 'ภาษา';

  @override
  String get paused => 'หยุดชั่วคราว';

  @override
  String get resume => 'เล่นต่อ';

  @override
  String get quit => 'ออก';

  @override
  String get gameOver => 'เกมจบลงแล้ว';

  @override
  String score(int score) {
    return 'คะแนน: $score';
  }

  @override
  String get playAgain => 'เล่นอีกครั้ง';

  @override
  String get menu => 'เมนู';
}
