import 'package:get/get.dart';
import 'package:zenzi/modules/download/controller/download_tab_bar_widget_controller.dart';

class DownloadPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadTabBarWidgetController>(
      () => DownloadTabBarWidgetController(),
    );
  }
}
