import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class MeditationsLikeController extends GetxController {
  ApiServices apiServices = ApiServices();

  Future<bool> toggleLike(String meditationId) async {
    try {
      final response = await apiServices.post(
        '/api/v1/content/meditations/$meditationId/like/',
        requireAuth: true,
      );
      final body = response.data;
      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar('Success', message);
      return true;
    } catch (e) {
      log('Error toggling like: $e');
      return false;
    }
  }

  Future<bool> handleLikeTap({
    required String meditationId,
    required Future<void> Function() reloadDetails,
  }) async {
    final bool liked = await toggleLike(meditationId);

    if (liked) {
      await reloadDetails();
    }

    return liked;
  }
}
