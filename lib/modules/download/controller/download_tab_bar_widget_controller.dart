import 'package:get/get.dart';

class DownloadTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  var selectedTabs = ['Lessons', 'Music'].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
