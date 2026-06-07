import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/game/spawn_timer.dart';

void main() {
  group('SpawnTimer', () {
    late SpawnTimer timer;

    setUp(() {
      timer = SpawnTimer(interval: 2.0);
    });

    test('does not spawn before interval', () {
      timer.update(1.0);
      expect(timer.shouldSpawn, false);
      expect(timer.elapsed, 1.0);
    });

    test('spawns after interval', () {
      timer.update(2.0);
      expect(timer.shouldSpawn, true);
      // automatically resets
      expect(timer.elapsed, 0.0);
    });

    test('reset clears elapsed time', () {
      timer.update(1.0);
      timer.reset();
      expect(timer.elapsed, 0.0);
    });

    test('paused timer does not spawn', () {
      timer.pause();
      timer.update(3.0);
      expect(timer.shouldSpawn, false);
      expect(timer.elapsed, 0.0);
    });

    test('resumed timer works again', () {
      timer.pause();
      timer.update(3.0);
      timer.resume();
      timer.update(2.0);
      expect(timer.shouldSpawn, true);
    });
  });
}
