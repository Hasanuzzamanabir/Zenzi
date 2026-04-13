import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/more/model/view_status_achievements_model.dart';

class ViewStatusAchievementsControllder extends GetxController {
  final ApiServices apiServices = ApiServices();

  Rxn<ViewStatusAchievementsModel> achievement =
      Rxn<ViewStatusAchievementsModel>();

  @override
  void onInit() {
    super.onInit();
    checkAchievementStatus();
  }

  Future<bool> checkAchievementStatus() async {
    try {
      final response = await apiServices.get(
        '/api/v1/activity/dashboard/',
        requireAuth: true,
      );

      final body = response.data;

      final result = body['data'];

      if (result != null) {
        achievement.value = ViewStatusAchievementsModel.fromJson(result);
      }

      log('Fetched achievement status: ${result.toString()}');
      log('Fetched achievement status: ${achievement.value.toString()}');
      return true;
    } catch (e) {
      return false;
    }
  }
}
