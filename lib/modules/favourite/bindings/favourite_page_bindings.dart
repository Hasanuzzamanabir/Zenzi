import 'package:get/get.dart';
import 'package:zenzi/modules/favourite/controller/favourite_tab_bar_widget_controller.dart';

class MusicPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteTabBarWidgetController>(
      () => FavouriteTabBarWidgetController(),
    );
  }
}
