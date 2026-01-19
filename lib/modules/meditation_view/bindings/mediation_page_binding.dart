import 'package:get/get.dart';
import 'package:zenzi/modules/meditation_view/controller/custom_tab_bar_widget_controller.dart';

class MeditationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomTabBarWidgetController>(
      () => CustomTabBarWidgetController(),
    );
  }
}
