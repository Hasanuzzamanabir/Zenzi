import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class HelpAndSupportController extends GetxController {
  RxBool isLoading = false.obs;
  final ApiServices apiServices = ApiServices();
  Future<void> getHelpAndSupport({
    required String name,
    required String email,
    required String description,
    required Function onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/support/tickets/',
        requireAuth: true,
        data: {'full_name': name, 'email': email, 'description': description},
      );
      final body = response.data;
      log('Help and Support Response: $body');
      if (response.statusCode == 201 || body['success'] == true) {
        final message = GetResponseMessage().getResponseMessage(body);
        Get.snackbar('Success', message);
        onSuccess();
      } else {
        final message = GetResponseMessage().getResponseMessage(body);
        Get.snackbar('Error', message);
      }
    } catch (e) {
      log('Help and Support Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
