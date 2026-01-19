import 'package:get/get.dart';

class CustomTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  var selectedTabs = ['All', 'My', 'Stress Relief', 'Healing', 'Head'].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
