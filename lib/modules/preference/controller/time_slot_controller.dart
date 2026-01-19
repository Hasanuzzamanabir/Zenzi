import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TimeSlotController extends GetxController {
  var selectedIndex = 0.obs;

  void select(int index) {
    selectedIndex.value = index;
  }
}
