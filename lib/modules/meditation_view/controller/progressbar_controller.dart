import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class ProgressbarController extends GetxController {
  final ApiServices apiServices = ApiServices();
  final pointsEarned = 0.obs;
  final totalPoints = 0.obs;
  final progressToNextLevel = 0.obs;
  final nextLevelThreshold = 1.obs;
  final currentLevel = 1.obs;
  final levelTitle = ''.obs;
  final leveledUp = false.obs;

  // Backward-compatible alias used by existing widgets.
  final nextLevelPoints = 1.obs;
  final isLoading = false.obs;

  Future<void> sendProgress({
    required int meditationId,
    required int watchedSeconds,
  }) async {
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/content/progress/',
        data: {
          'meditation_id': meditationId,
          'watched_seconds': watchedSeconds,
          'is_completed': true,
        },
        requireAuth: true,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final Map<String, dynamic> data =
            response.data['data'] as Map<String, dynamic>? ??
            <String, dynamic>{};

        pointsEarned.value = data['points_earned'] ?? 0;
        totalPoints.value = data['total_points'] ?? 0;
        currentLevel.value = data['current_level'] ?? currentLevel.value;
        levelTitle.value = (data['level_title'] ?? '').toString();
        leveledUp.value = data['leveled_up'] ?? false;

        progressToNextLevel.value =
            data['progress_to_next_level'] ?? totalPoints.value;
        nextLevelThreshold.value =
            data['next_level_threshold'] ?? data['next_level_points'] ?? 1;

        // Keep old binding alive for screens still reading nextLevelPoints.
        nextLevelPoints.value = nextLevelThreshold.value;
      }
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }
}