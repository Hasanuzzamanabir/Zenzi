import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class HistoryDeleteController extends GetxController {
  RxBool isLoading = false.obs;

  ApiServices apiServices = ApiServices();

  Future<bool> deleteJournalEntry(int id) async {
    try {
      isLoading.value = true;
      final response = await apiServices.delete(
        '/api/v1/activity/journal/$id/',
        requireAuth: true,
      );
      final body = response.data;
      log('Delete Response: $body');
      final message = GetResponseMessage().getResponseMessage(body);

      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete journal entry');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
