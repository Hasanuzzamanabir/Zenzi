import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class BreathingSessionsController extends GetxController {
  ApiServices apiServices = ApiServices();

  Future<void> breathingCompletedToSend(
    int id,
    int cycleCompleted,
    int totalSeconds,
  ) async {
    try {
      final response = await apiServices.post(
        '/api/v1/activity/breathing-sessions/log/',
        requireAuth: true,
        data: {
          "exercise_id": id,
          "cycles_completed": cycleCompleted,
          "total_seconds": totalSeconds,
        },
      );

      final body = response.data;
      final success = GetResponseMessage().getResponseMessage(body);
      Get.snackbar("Success", success);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
