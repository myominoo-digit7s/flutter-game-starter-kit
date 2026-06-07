import 'package:flame_audio/flame_audio.dart';
import '../utils/app_logger.dart';

class AudioService {
  bool _soundEnabled = true;
  bool _musicEnabled = true;

  void updateSettings({
    required bool soundEnabled,
    required bool musicEnabled,
  }) {
    _soundEnabled = soundEnabled;
    _musicEnabled = musicEnabled;

    if (!_musicEnabled) {
      stopBgm();
    }
  }

  Future<void> prefetch() async {
    try {
      // Pre-load audio files here when they exist
      // await FlameAudio.audioCache.loadAll(['bgm.mp3', 'sfx.wav']);
      AppLogger.log('Audio prefetch skipped (no files yet).');
    } catch (e) {
      AppLogger.error('Failed to prefetch audio: $e');
    }
  }

  void playSfx(String file) {
    if (!_soundEnabled) return;

    try {
      FlameAudio.play(file);
    } catch (e) {
      AppLogger.error('Failed to play SFX ($file): $e');
    }
  }

  void playBgm(String file) {
    if (!_musicEnabled) return;

    try {
      FlameAudio.bgm.play(file);
    } catch (e) {
      AppLogger.error('Failed to play BGM ($file): $e');
    }
  }

  void stopBgm() {
    try {
      FlameAudio.bgm.stop();
    } catch (e) {
      AppLogger.error('Failed to stop BGM: $e');
    }
  }

  void pauseBgm() {
    try {
      FlameAudio.bgm.pause();
    } catch (e) {
      AppLogger.error('Failed to pause BGM: $e');
    }
  }

  void resumeBgm() {
    if (!_musicEnabled) return;

    try {
      FlameAudio.bgm.resume();
    } catch (e) {
      AppLogger.error('Failed to resume BGM: $e');
    }
  }
}
