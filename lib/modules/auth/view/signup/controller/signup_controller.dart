import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool isPasswordObscured = true.obs;
  RxBool isConfirmPasswordObscured = true.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;
  }
}
