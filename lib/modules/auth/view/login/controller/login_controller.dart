import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';

class LoginController extends GetxController {
  RxBool isObscure = false.obs;
  late final Dio dio = Dio();

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/accounts/login/',
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
    } on DioException catch (e) {
      log('Login Error: $e');
      Get.snackbar('Error', 'Login failed.');
    } catch (e) {
      log('Login Error: $e');
      Get.snackbar('Error', 'Login failed.');
    } finally {
      isLoading.value = false;
    }
  }
}
