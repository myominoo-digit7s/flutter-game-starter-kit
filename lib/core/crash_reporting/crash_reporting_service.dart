abstract class CrashReportingService {
  Future<void> initialize();

  Future<void> setCrashCollectionEnabled(bool enabled);

  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
    Map<String, Object?> information = const {},
  });

  Future<void> log(String message);

  Future<void> setCustomKey(String key, Object value);

  Future<void> setUserIdentifier(String identifier);
}
