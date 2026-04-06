import 'dart:developer';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class ThirdPageController extends GetxController {
  var isLoading = false.obs;
  final ApiServices apiServices = ApiServices();

  Future<bool> completeOnboarding() async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/profiles/onboarding/complete/',
        requireAuth: true,
      );
      final body = response.data;
      log('Onboarding complete response: $body');
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      log('Error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
