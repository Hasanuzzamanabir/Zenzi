import 'package:get/get.dart';
import 'package:zenzi/modules/music/controller/music_tab_bar_widget_controller.dart';

class MusicPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicTabBarWidgetController>(
      () => MusicTabBarWidgetController(),
    );
  }
}
