import 'package:get/get.dart';

class MusicTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  var selectedTabs = ['All', 'My', 'Sleep', 'Healing', 'Relax'].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
