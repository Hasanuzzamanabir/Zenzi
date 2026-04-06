import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class TimeSlotController extends GetxController {
  var selectedIndex = 0.obs;
   var isLoading = false.obs;
   final Dio dio = Dio();

  void select(int index) {
    selectedIndex.value = index;
  }
   final ApiServices apiServices = ApiServices();

}
