import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/breath_page/model/breathing_model.dart';

class BreathingController extends GetxController {
  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  RxList<BreathingModel> breathingExercises = <BreathingModel>[].obs;

  @override
  onInit() {
    super.onInit();
    fetchBreathingData();
  }

  Future<bool> fetchBreathingData() async {
    try {
      isLoading.value = true;
      final response = await apiServices.get(
        '/api/v1/content/breathing-exercises/',
        requireAuth: true,
      );

      final body = response.data;

      final List<dynamic> result = body['data']?['results'] ?? [];

      breathingExercises.value = result
          .map((item) => BreathingModel.fromJson(item as Map<String, dynamic>))
          .toList();

      Get.snackbar('Success', 'Breathing data fetched successfully.');
      return true;
    } catch (e) {
      log('Error fetching breathing data: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
