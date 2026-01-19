import 'package:get/get.dart';

class JournalTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  var selectedTabs = ['Daily', 'History'].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
