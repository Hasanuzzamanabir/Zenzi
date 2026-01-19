import 'package:get/get.dart';
import 'package:zenzi/data/models/music_model.dart';

class MusicController extends GetxController {
  var musicList = <MusicModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMusic();
  }

  void fetchMusic() async {
    try {
      isLoading(true);
      // Mocking a web fetch with a delay
      await Future.delayed(const Duration(seconds: 1));

      var mockData = [
        MusicModel(
          id: '1',
          title: 'Deep Meditation',
          subtitle: 'Calm Your Mind',
          duration: '10:00',
          audioUrl:
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
          imageUrl:
              'https://images.unsplash.com/photo-1518241353349-9b5718ef33c7?q=80&w=200&auto=format&fit=crop',
        ),
        MusicModel(
          id: '2',
          title: 'Ocean Waves',
          subtitle: 'Soft Background',
          duration: '05:30',
          audioUrl:
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
          imageUrl:
              'https://images.unsplash.com/photo-1505118380757-91f5f45d8de8?q=80&w=200&auto=format&fit=crop',
        ),
        MusicModel(
          id: '3',
          title: 'Forest Ambient',
          subtitle: 'Nature Sounds',
          duration: '08:15',
          audioUrl:
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
          imageUrl:
              'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=200&auto=format&fit=crop',
        ),
        MusicModel(
          id: '4',
          title: 'Inner Peace',
          subtitle: 'Relaxing Zen',
          duration: '12:45',
          audioUrl:
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
          imageUrl:
              'https://images.unsplash.com/photo-1499209974431-9dac3e74a1fc?q=80&w=200&auto=format&fit=crop',
        ),
        MusicModel(
          id: '5',
          title: 'Starlight Piano',
          subtitle: 'Soft Melodies',
          duration: '06:20',
          audioUrl:
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
          imageUrl:
              'https://images.unsplash.com/photo-1520529682324-21014a60db2c?q=80&w=200&auto=format&fit=crop',
        ),
      ];

      musicList.assignAll(mockData);
    } finally {
      isLoading(false);
    }
  }
}
