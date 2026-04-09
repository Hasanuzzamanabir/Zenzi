import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zenzi/data/models/music_model.dart';

class AudioPlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _loadedTrackId;

  var currentMusic = Rxn<MusicModel>();
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();

    _audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      position.value = Duration.zero;
    });
  }

  Future<bool> playMusic(MusicModel music) async {
    if (currentMusic.value?.id == music.id && isPlaying.value) {
      await _pauseCurrent();
      return true;
    }

    if (currentMusic.value?.id == music.id && !isPlaying.value) {
      if (_loadedTrackId == music.id) {
        final bool resumed = await _resumeCurrent();
        if (resumed) {
          return true;
        }
      }

      // If resume failed or no source was loaded yet, fall back to fresh play.
    }

    final String url = music.audioUrl.trim();
    final Uri? parsed = Uri.tryParse(url);
    if (url.isEmpty || parsed == null || !parsed.hasScheme) {
      Get.snackbar(
        'Playback unavailable',
        'This track has an invalid audio URL.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    try {
      currentMusic.value = music;
      _loadedTrackId = null;
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(parsed.toString()));
      _loadedTrackId = music.id;
      return true;
    } on PlatformException {
      isPlaying.value = false;
      _loadedTrackId = null;
      Get.snackbar(
        'Playback failed',
        'Could not open this audio source.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TimeoutException {
      isPlaying.value = false;
      _loadedTrackId = null;
      Get.snackbar(
        'Playback timeout',
        'Audio source took too long to respond.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      isPlaying.value = false;
      _loadedTrackId = null;
      Get.snackbar(
        'Playback failed',
        'Something went wrong while playing this track.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return false;
  }

  Future<void> togglePlayPause() async {
    if (isPlaying.value) {
      await _pauseCurrent();
    } else {
      if (currentMusic.value != null) {
        await _resumeCurrent();
      }
    }
  }

  Future<void> seek(Duration pos) async {
    try {
      await _audioPlayer.seek(pos);
    } on TimeoutException {
      Get.snackbar(
        'Seek timeout',
        'Could not seek audio position right now.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Seek failed',
        'Could not update audio position.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> _pauseCurrent() async {
    try {
      await _audioPlayer.pause();
      return true;
    } on TimeoutException {
      isPlaying.value = false;
      Get.snackbar(
        'Pause timeout',
        'Player did not respond in time.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      isPlaying.value = false;
    }

    return false;
  }

  Future<bool> _resumeCurrent() async {
    try {
      await _audioPlayer.resume();
      return true;
    } on TimeoutException {
      isPlaying.value = false;
      Get.snackbar(
        'Resume timeout',
        'Player did not respond in time.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      isPlaying.value = false;
    }

    return false;
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
