import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class JournalTodayController extends GetxController {
  RxBool isLoading = false.obs;

  ApiServices apiServices = ApiServices();

  Future<bool> dailyMoodSend(String mood, String note) async {
    final dataFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/activity/journal/today/',
        requireAuth: true,
        data: {"mood": mood, "note": note, "date": dataFormat},
      );
      final body = response.data;

      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Journal Entry', message);
      return true;
    } catch (e) {
      log('Error sending daily mood: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
