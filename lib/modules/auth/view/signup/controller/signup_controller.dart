import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/network/error/api_exception.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
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

  Future<bool> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    isLoading.value = true;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return false;
    }

    if (password.length < 8) {
      Get.snackbar('Error', 'Password must be at least 8 characters long');
      return false;
    }

    try {
      final response = await apiServices.post(
        '/api/v1/accounts/register/',
        requireAuth: false,
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
      return true;
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message);
      return false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
