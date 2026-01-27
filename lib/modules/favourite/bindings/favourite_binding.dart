import 'package:get/get.dart';
import 'package:zenzi/modules/favourite/controller/favourite_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/music/controller/audio_player_controller.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteTabBarWidgetController>(
      () => FavouriteTabBarWidgetController(),
    );
    Get.lazyPut<MusicController>(() => MusicController());
    Get.lazyPut<AudioPlayerController>(() => AudioPlayerController());
  }
}
