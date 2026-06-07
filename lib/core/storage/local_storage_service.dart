abstract class LocalStorageService {
  Future<void> setBool(String key, bool value);
  bool? getBool(String key);

  Future<void> setString(String key, String value);
  String? getString(String key);

  Future<void> setInt(String key, int value);
  int? getInt(String key);

  Future<void> remove(String key);
  Future<void> clear();
}
