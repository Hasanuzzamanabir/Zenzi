import 'package:get/get.dart';

class StatisticAndAchivementTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  var selectedTabs = ['Stats', 'Achievement'].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
