import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class TimeSlotController extends GetxController {
  var selectedIndex = 0.obs;

  void select(int index) {
    selectedIndex.value = index;
  }

  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  Future<bool> setReminderTime() async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/profiles/onboarding/step-2/',
        requireAuth: true,
        data: {"preference": selectedIndex.value == 0 ? "MORNING" : "EVENING"},
      );
      final body = response.data;
      log("Response body: $body");
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar("Success", message);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
