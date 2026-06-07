import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_game_starter_kit/core/storage/shared_preferences_storage_service.dart';

void main() {
  group('LocalStorageService', () {
    late SharedPreferencesStorageService storageService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      storageService = SharedPreferencesStorageService(prefs);
    });

    test('set/get bool', () async {
      await storageService.setBool('test_bool', true);
      expect(storageService.getBool('test_bool'), true);
    });

    test('set/get string', () async {
      await storageService.setString('test_string', 'value');
      expect(storageService.getString('test_string'), 'value');
    });

    test('set/get int', () async {
      await storageService.setInt('test_int', 42);
      expect(storageService.getInt('test_int'), 42);
    });

    test('remove key', () async {
      await storageService.setString('key1', 'value1');
      await storageService.remove('key1');
      expect(storageService.getString('key1'), null);
    });

    test('clear storage', () async {
      await storageService.setString('key1', 'value1');
      await storageService.setInt('key2', 2);
      await storageService.clear();
      expect(storageService.getString('key1'), null);
      expect(storageService.getInt('key2'), null);
    });
  });
}
