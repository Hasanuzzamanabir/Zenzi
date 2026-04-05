import 'dart:developer';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';

class OtpVerificationController extends GetxController {
  final ApiServices apiServices = ApiServices();

  //Otp Verification
  RxBool isLoading = false.obs;
  Future<bool> verifyOtp(
    String otp, {
    bool isForgotPassword = false,
    String? email,
  }) async {
    try {
      isLoading.value = true;
      final userEmail = email ?? await TokenStorage.getUserEmail();
      final endpoint = isForgotPassword
          ? '/api/v1/accounts/verify-password-otp/'
          : '/api/v1/accounts/verify-registration-otp/';
      final response = await apiServices.post(
        endpoint,
        requireAuth: false,
        data: {'email': userEmail, 'otp_code': otp},
      );
      final body = response.data;

      if (isForgotPassword) {
        await TokenStorage.savePasswordResetData(
          body['data']['uid'],
          body['data']['token'],
        );
      }

      log(body.toString());
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      log('Error verifying OTP: $e');
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  //Resend OTP
  RxBool isOtpLoading = false.obs;

  Future<void> resendOtp({bool isForgotPassword = false, String? email}) async {
    try {
      isOtpLoading.value = true;
      final userEmail = email ?? await TokenStorage.getUserEmail();

      final response = await apiServices.post(
        '/api/v1/accounts/resend-otp/',
        requireAuth: false,
        data: {
          'email': userEmail,
          'purpose': isForgotPassword ? 'PASSWORD_RESET' : 'REGISTRATION',
        },
      );
      final body = response.data;
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      log(body.toString());
    } catch (e) {
      log('Error resending OTP: $e');
    } finally {
      isOtpLoading.value = false;
    }
  }
}
