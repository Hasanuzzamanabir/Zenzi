import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/meditation_view/model/meditations_model.dart';

class FavouriteLessonsController extends GetxController {
  final ApiServices apiServices = ApiServices();

  final isLoading = true.obs;
  final lessonsList = <MeditationsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFavouriteLessons();
  }

  Future<void> getFavouriteLessons() async {
    try {
      isLoading.value = true;

      final response = await apiServices.get(
        '/api/v1/content/favorites/lessons/',
        requireAuth: true,
      );

      final body = response.data;
      final List<dynamic> dataList =
          (body['data']?['results'] as List<dynamic>? ?? <dynamic>[]);

      final lessons = dataList
          .map(
            (item) => MeditationsModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();

      lessonsList.assignAll(lessons);
      log('Favourite lessons fetched: ${lessonsList.length}');
    } catch (e) {
      lessonsList.clear();
      log('Favourite lessons API error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
