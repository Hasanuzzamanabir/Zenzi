import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class AccountDeletedController extends GetxController {
  RxBool isPassword = true.obs;

  void passwordVisibility() {
    isPassword.value = !isPassword.value;
  }

  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  Future<bool> deleteAccount(String password) async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/accounts/delete-account/',
        requireAuth: true,
        data: {'password': password},
      );
      final body = response.data;
      log("Delete account: $body");
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
