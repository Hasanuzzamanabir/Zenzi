import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';

class OtpVerificationController extends GetxController {
  RxBool isOtpLoading = false.obs;
  final ApiServices apiServices = ApiServices();

  Future<void> resendOtp() async {
    try {
      final userEmail = await TokenStorage.getUserEmail();
      isOtpLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/accounts/resend-otp/',
        data: {'email': userEmail, 'purpose': "REGISTRATION"},
      );
      final body = response.data;
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      print(body);
    } catch (e) {
      print('Error resending OTP: $e');
    } finally {
      isOtpLoading.value = false;
    }
  }
}
