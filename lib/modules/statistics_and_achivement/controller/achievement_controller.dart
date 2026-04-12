import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/statistics_and_achivement/model/achievement_model.dart';

class AchievementController extends GetxController {
  final ApiServices _apiServices = ApiServices();

  final RxBool isLoading = false.obs;
  final Rxn<AchievementResponse> achievements = Rxn<AchievementResponse>();

  @override
  void onInit() {
    super.onInit();
    fetchAchievements();
  }

  Future<void> fetchAchievements({int page = 1}) async {
    try {
      isLoading.value = true;

      final response = await _apiServices.get(
        '/api/v1/activity/achievements/?page=$page',
        requireAuth: true,
      );

      final body =
          response.data as Map<String, dynamic>? ?? <String, dynamic>{};

      achievements.value = AchievementResponse.fromJson(body);
    } catch (e) {
      log('fetchAchievements error: $e');
      achievements.value = AchievementResponse(count: 0, results: []);
      Get.snackbar('Error', 'Failed to load achievements. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
