import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game_starter_kit/core/audio/audio_service.dart';

void main() {
  group('AudioService', () {
    test(
      'plays configured sound effects and allows repeated playback',
      () async {
        final playedFiles = <String>[];
        final service = AudioService(
          soundEffectPlayer: (file) async => playedFiles.add(file),
        );

        service.playSfx('collect.wav');
        service.playSfx('collect.wav');
        await Future<void>.delayed(Duration.zero);

        expect(playedFiles, ['collect.wav', 'collect.wav']);
      },
    );

    test('does not play effects while sound is disabled', () async {
      var playCount = 0;
      final service = AudioService(
        soundEffectPlayer: (_) async {
          playCount++;
        },
      );
      service.updateSettings(soundEnabled: false, musicEnabled: true);

      service.playSfx('collect.wav');
      await Future<void>.delayed(Duration.zero);

      expect(playCount, 0);
    });

    test('handles asynchronous playback failures without escaping', () async {
      final service = AudioService(
        soundEffectPlayer: (_) async => throw StateError('missing audio asset'),
      );

      expect(() {
        service.playSfx('missing.wav');
        service.playSfx('missing.wav');
      }, returnsNormally);
      await Future<void>.delayed(Duration.zero);
    });

    test(
      'music settings start and stop music without bypassing the toggle',
      () async {
        final playedFiles = <String>[];
        var stopCount = 0;
        final service = AudioService(
          backgroundMusicPlayer: (file) async {
            playedFiles.add(file);
          },
          stopBackgroundMusic: () async {
            stopCount++;
          },
        );

        service.playBgm('theme.mp3');
        service.updateSettings(soundEnabled: true, musicEnabled: false);
        service.playBgm('muted.mp3');
        await Future<void>.delayed(Duration.zero);

        expect(playedFiles, ['theme.mp3']);
        expect(stopCount, 1);
      },
    );
  });
}
