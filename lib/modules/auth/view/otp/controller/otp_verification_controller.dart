import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';

class OtpVerificationController extends GetxController {
  final ApiServices apiServices = ApiServices();

  //Otp Verification
  RxBool isLoading = false.obs;
  Future<bool> verifyOtp(String otp) async {
    try {
      isLoading.value = true;
      final userEmail = await TokenStorage.getUserEmail();
      final response = await apiServices.post(
        '/api/v1/accounts/verify-registration-otp/',
        requireAuth: false,
        data: {'email': userEmail, 'otp_code': otp},
      );
      final body = response.data;
      print(body);
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      print('Error verifying OTP: $e');
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  //Resend OTP
  RxBool isOtpLoading = false.obs;

  Future<void> resendOtp() async {
    try {
      final userEmail = await TokenStorage.getUserEmail();
      isOtpLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/accounts/resend-otp/',
        requireAuth: false,
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
