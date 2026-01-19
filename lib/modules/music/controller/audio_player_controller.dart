import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:zenzi/data/models/music_model.dart';

class AudioPlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

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

  void playMusic(MusicModel music) async {
    if (currentMusic.value?.id == music.id && isPlaying.value) {
      await _audioPlayer.pause();
      return;
    }

    if (currentMusic.value?.id == music.id && !isPlaying.value) {
      await _audioPlayer.resume();
      return;
    }

    currentMusic.value = music;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(music.audioUrl));
  }

  void togglePlayPause() async {
    if (isPlaying.value) {
      await _audioPlayer.pause();
    } else {
      if (currentMusic.value != null) {
        await _audioPlayer.resume();
      }
    }
  }

  void seek(Duration pos) async {
    await _audioPlayer.seek(pos);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
