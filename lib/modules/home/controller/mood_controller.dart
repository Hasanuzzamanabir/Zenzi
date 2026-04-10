import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class MoodController extends GetxController {
  final ApiServices apiServices = ApiServices();
  var isLoading = false.obs;
  final List<Map<String, String>> moods = [
    {'emoji': '😊', 'label': 'GREAT'},
    {'emoji': '🙂', 'label': 'GOOD'},
    {'emoji': '😐', 'label': 'OKAY'},
    {'emoji': '😔', 'label': 'LOW'},
    {'emoji': '😰', 'label': 'ANXIOUS'},
  ];
  final selectedMoodIndex = (-1).obs;

  Future<void> selectMood(int index) async {
    selectedMoodIndex.value = index;
    String moodLabel = moods[index]['label']!;
    await postMood(moodLabel);
  }

  Future<void> postMood(String mood) async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/content/mood/',
        data: {'mood': mood},
        requireAuth: true,
      );
      final body = response.data;
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar(mood, message, snackPosition: SnackPosition.BOTTOM);
      log(response.data);
    } catch (e) {
      log('Error posting mood: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
