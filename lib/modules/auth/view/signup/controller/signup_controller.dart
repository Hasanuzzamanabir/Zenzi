import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/base_url/base_url.dart';

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

    try {
      isLoading.value = true;
      final response = await dio.post(
        "${BaseUrl.baseUrl}/api/v1/accounts/register/",

        data: {
          "name": name,
          "email": email,
          "password": password,
          "confirm_password": confirmPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Account created successfully');
        // Navigate to OTP verification or login page
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Error',
        'error: ${e.response?.data['error'] ?? 'Unknown error'}',
      );
    } catch (_) {
      Get.snackbar('Error', 'Unexpected error occurred during sign up');
    } finally {
      isLoading.value = false;
    }
  }
}
