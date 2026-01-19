import 'package:get/get.dart';

class FavouriteTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  var selectedTabs = ['Lessons', 'Music', 'Affirm'].obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
