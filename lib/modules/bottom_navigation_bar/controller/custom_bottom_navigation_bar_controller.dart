import 'package:get/get.dart';

class CustomBottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs;
  final RxnString requestedMusicTabTitle = RxnString();

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void requestMusicTabSelection(String tabTitle) {
    requestedMusicTabTitle.value = tabTitle;
  }

  String? consumeRequestedMusicTabSelection() {
    final tabTitle = requestedMusicTabTitle.value;
    requestedMusicTabTitle.value = null;
    return tabTitle;
  }
}
