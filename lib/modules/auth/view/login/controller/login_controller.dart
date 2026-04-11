import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';
import 'package:zenzi/modules/bottom_navigation_bar/controller/custom_bottom_navigation_bar_controller.dart';
import 'package:zenzi/routes/app_routes.dart';

class LoginController extends GetxController {
  RxBool isObscure = true.obs;
  late final Dio dio = Dio();

  void resetPasswordVisibility() {
    isObscure.value = true;
  }

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/accounts/login/',
        requireAuth: false,
        data: {'email': email, 'password': password},
      );

      final body = response.data;
      log('Login Response: $body');

      final accessToken = body['data']['access'];
      final freshToken = body['data']['refresh'];

      await TokenStorage.saveAccessToken(accessToken.toString());
      await TokenStorage.saveRefreshToken(freshToken.toString());

      print('Access Token: $accessToken');
      print('Refresh Token: $freshToken');

      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } on DioException catch (e) {
      log('Login Error: $e');
      Get.snackbar('Error', 'Login failed.');
      return false;
    } catch (e) {
      log('Login Error: $e');
      Get.snackbar('Error', 'Login failed.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      resetPasswordVisibility();
      await TokenStorage.clearTokens();

      if (Get.isRegistered<CustomBottomNavigationBarController>()) {
        Get.delete<CustomBottomNavigationBarController>(force: true);
      }

      Get.offAllNamed(AppRoute.loginView);
      Get.snackbar('Success', 'Logged out successfully.');
    } catch (e) {
      log('Logout Error: $e');
      Get.snackbar('Error', 'Logout failed.');
    }
  }
}
