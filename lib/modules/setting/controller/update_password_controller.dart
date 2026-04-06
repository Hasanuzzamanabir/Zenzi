import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class UpdatePasswordController extends GetxController {
  RxBool currentPassword = true.obs;
  RxBool newPassword = true.obs;
  RxBool confirmPassword = true.obs;

  void toggleCurrentPassword() {
    currentPassword.value = !currentPassword.value;
  }

  void toggleNewPassword() {
    newPassword.value = !newPassword.value;
  }

  void toggleConfirmPassword() {
    confirmPassword.value = !confirmPassword.value;
  }

  void resetVisibility() {
    currentPassword.value = true;
    newPassword.value = true;
    confirmPassword.value = true;
  }

  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  Future<bool> updatePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return false;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return false;
    }

    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/accounts/update-password/',
        requireAuth: true,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'confirm_new_password': confirmPassword,
        },
      );
      final body = response.data;
      log("Update password: $body");
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
