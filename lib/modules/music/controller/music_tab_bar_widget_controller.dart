import 'package:get/get.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';

class MusicTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;
  final MusicController musicController = Get.find<MusicController>();

  var selectedTabs = ['All', 'My', 'Sleep', 'Healing', 'Relax'].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;

    switch (index) {
      case 1:
        musicController.applyTabFilter(categorySlug: '', onlyFavorites: true);
        break;
      case 2:
        musicController.applyTabFilter(
          categorySlug: 'sleep',
          onlyFavorites: false,
        );
        break;
      case 3:
        musicController.applyTabFilter(
          categorySlug: 'healing',
          onlyFavorites: false,
        );
        break;
      case 4:
        musicController.applyTabFilter(
          categorySlug: 'relax',
          onlyFavorites: false,
        );
        break;
      default:
        musicController.applyTabFilter(categorySlug: '', onlyFavorites: false);
    }
  }
}
