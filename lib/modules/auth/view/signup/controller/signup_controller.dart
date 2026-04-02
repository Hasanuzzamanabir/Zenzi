import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/error/api_exception.dart';
import 'package:zenzi/core/error/get_response_message.dart';
import 'package:zenzi/core/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';

class SignupController extends GetxController {
  RxBool isPasswordObscured = true.obs;
  RxBool isConfirmPasswordObscured = true.obs;

  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ),
  );

  RxBool checkBoxValue = false.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;
  }

  void toggleCheckBox(bool? abir) {
    checkBoxValue.value = abir ?? false;
  }

  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  Future<void> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (isLoading.value) return;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    if (password.length < 8) {
      Get.snackbar('Error', 'Password must be at least 8 characters long');
      return;
    }

    try {
      final response = await apiServices.post(
        '${BaseUrl.baseUrl}/api/v1/accounts/register/',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );
      final body = response.data;

      final userEmail = body['data']['email'];

      await TokenStorage.saveUserEmail(userEmail.toString());
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message);
    } finally {
      isLoading.value = false;
    }
  }
}
