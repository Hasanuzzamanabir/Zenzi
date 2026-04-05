import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  final ApiServices apiServices = ApiServices();

  Future<bool> sendResetPasswordEmail(String email) async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/accounts/forgot-password/',
        requireAuth: false,
        data: {'email': email},
      );
      final body = response.data;
      log('Forgot Password Response: $body');
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to send reset password email.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
