import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import '../utils/app_logger.dart';

typedef SoundEffectPlayer = Future<void> Function(String file);
typedef BackgroundMusicPlayer = Future<void> Function(String file);
typedef BackgroundMusicAction = Future<void> Function();

class AudioService {
  final SoundEffectPlayer _soundEffectPlayer;
  final BackgroundMusicPlayer _backgroundMusicPlayer;
  final BackgroundMusicAction _stopBackgroundMusic;
  final BackgroundMusicAction _pauseBackgroundMusic;
  final BackgroundMusicAction _resumeBackgroundMusic;
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  final Set<String> _reportedPlaybackFailures = {};

  AudioService({
    SoundEffectPlayer? soundEffectPlayer,
    BackgroundMusicPlayer? backgroundMusicPlayer,
    BackgroundMusicAction? stopBackgroundMusic,
    BackgroundMusicAction? pauseBackgroundMusic,
    BackgroundMusicAction? resumeBackgroundMusic,
  }) : _soundEffectPlayer = soundEffectPlayer ?? _playFlameSoundEffect,
       _backgroundMusicPlayer =
           backgroundMusicPlayer ?? _playFlameBackgroundMusic,
       _stopBackgroundMusic = stopBackgroundMusic ?? _stopFlameBackgroundMusic,
       _pauseBackgroundMusic =
           pauseBackgroundMusic ?? _pauseFlameBackgroundMusic,
       _resumeBackgroundMusic =
           resumeBackgroundMusic ?? _resumeFlameBackgroundMusic;

  static Future<void> _playFlameSoundEffect(String file) async {
    await FlameAudio.play(file);
  }

  static Future<void> _playFlameBackgroundMusic(String file) {
    return FlameAudio.bgm.play(file);
  }

  static Future<void> _stopFlameBackgroundMusic() => FlameAudio.bgm.stop();

  static Future<void> _pauseFlameBackgroundMusic() => FlameAudio.bgm.pause();

  static Future<void> _resumeFlameBackgroundMusic() => FlameAudio.bgm.resume();

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

    unawaited(
      _runPlaybackSafely(
        'sound effect:$file',
        'sound effect',
        () => _soundEffectPlayer(file),
      ),
    );
  }

  void playBgm(String file) {
    if (!_musicEnabled) return;

    unawaited(
      _runPlaybackSafely(
        'background music:$file',
        'background music',
        () => _backgroundMusicPlayer(file),
      ),
    );
  }

  void stopBgm() {
    unawaited(
      _runPlaybackSafely(
        'stop background music',
        'background music',
        _stopBackgroundMusic,
      ),
    );
  }

  void pauseBgm() {
    unawaited(
      _runPlaybackSafely(
        'pause background music',
        'background music',
        _pauseBackgroundMusic,
      ),
    );
  }

  void resumeBgm() {
    if (!_musicEnabled) return;

    unawaited(
      _runPlaybackSafely(
        'resume background music',
        'background music',
        _resumeBackgroundMusic,
      ),
    );
  }

  Future<void> _runPlaybackSafely(
    String failureKey,
    String audioKind,
    Future<void> Function() playback,
  ) async {
    try {
      await playback();
    } catch (_) {
      if (_reportedPlaybackFailures.add(failureKey)) {
        AppLogger.error('Unable to play optional $audioKind.');
      }
    }
  }
}
