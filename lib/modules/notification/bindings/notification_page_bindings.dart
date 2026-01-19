import 'package:get/get.dart';
import 'package:zenzi/modules/notification/controller/notificatioin_tab_bar_widget_controller.dart';

class MusicPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationTabBarWidgetController>(
      () => NotificationTabBarWidgetController(),
    );
  }
}
