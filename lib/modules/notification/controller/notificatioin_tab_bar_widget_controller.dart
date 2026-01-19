import 'package:get/get.dart';

class NotificationTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  var selectedTabs = ['All', 'Unread', 'Reminders', 'Updates'].obs;
  var tabCounts = [6, 2, 1, 2].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
