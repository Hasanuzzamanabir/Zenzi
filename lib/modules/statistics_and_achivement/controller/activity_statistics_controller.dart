import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/statistics_and_achivement/model/activity_statistics_model.dart';

class ActivityStatisticsController extends GetxController {
  final ApiServices _apiServices = ApiServices();

  final RxBool isLoading = false.obs;
  final Rxn<ActivityStatisticsModel> statistics =
      Rxn<ActivityStatisticsModel>();

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    try {
      isLoading.value = true;

      final response = await _apiServices.get(
        '/api/v1/activity/statistics/',
        requireAuth: true,
      );

      final body =
          response.data as Map<String, dynamic>? ?? <String, dynamic>{};
      final data = body['data'] as Map<String, dynamic>?;

      if (body['success'] == true && data != null) {
        statistics.value = ActivityStatisticsModel.fromJson(data);
        return;
      }

      statistics.value = null;
      Get.snackbar(
        'Error',
        (body['message'] ?? 'Failed to load statistics').toString(),
      );
    } catch (e) {
      log('fetchStatistics error: $e');
      statistics.value = null;
      Get.snackbar('Error', 'Failed to load statistics. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
