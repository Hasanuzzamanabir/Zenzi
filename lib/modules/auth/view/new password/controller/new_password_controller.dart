import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';

class NewPasswordController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void resetVisibility() {
    isPasswordVisible.value = true;
    isConfirmPasswordVisible.value = true;
  }

  RxBool isResetLoading = false.obs;

  final ApiServices apiServices = ApiServices();

  Future<bool> resetPassword(String newPassword, String cofirmPassword) async {
    if (newPassword.isEmpty || cofirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return false;
    }

    if (newPassword != cofirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return false;
    }

    try {
      isResetLoading.value = true;
      final uid = await TokenStorage.getUid();
      final token = await TokenStorage.getResetToken();

      final response = await apiServices.post(
        '/api/v1/accounts/reset-password/',
        requireAuth: false,
        data: {
          'uidB64': uid,
          'token': token,
          'new_password': newPassword,
          'confirm_password': cofirmPassword,
        },
      );
      final body = response.data;
      log('Reset Password Response: $body');
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to reset password.');
      log('Reset Password Error: $e');
      return false;
    } finally {
      isResetLoading.value = false;
    }
  }
}
