import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isObscure = false.obs;

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }
}
