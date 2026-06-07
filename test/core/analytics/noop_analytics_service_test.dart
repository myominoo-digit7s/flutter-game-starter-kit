import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/analytics/analytics_config.dart';
import 'package:flutter_game_starter_kit/core/analytics/analytics_event.dart';
import 'package:flutter_game_starter_kit/core/analytics/noop_analytics_service.dart';

void main() {
  group('NoopAnalyticsService', () {
    test('Initialization works without errors', () async {
      final service = NoopAnalyticsService(config: const AnalyticsConfig());
      expect(() => service.initialize(), returnsNormally);
    });

    test('Events can be logged safely when enabled', () async {
      final service = NoopAnalyticsService(config: const AnalyticsConfig(enabled: true));
      expect(
        () => service.logEvent(AnalyticsEvent(name: 'test_event')),
        returnsNormally,
      );
    });

    test('Session events can be logged safely', () async {
      final service = NoopAnalyticsService(config: const AnalyticsConfig(collectRetentionEvents: true));
      expect(() => service.logSessionStart(sessionId: '123'), returnsNormally);
      expect(() => service.logSessionEnd(sessionId: '123', duration: const Duration(seconds: 10)), returnsNormally);
    });

    test('Game events can be logged safely', () async {
      final service = NoopAnalyticsService(config: const AnalyticsConfig(collectGameEvents: true));
      expect(
        () => service.logGameOver(
          gameId: 'test',
          gameName: 'test',
          score: 10,
          bestScore: 20,
          duration: const Duration(seconds: 10),
          isNewBestScore: false,
        ),
        returnsNormally,
      );
    });

    test('Ad events can be logged safely', () async {
      final service = NoopAnalyticsService(config: const AnalyticsConfig(collectAdEvents: true));
      expect(() => service.logRewardedAdShown(placement: 'test_placement'), returnsNormally);
    });
  });
}
