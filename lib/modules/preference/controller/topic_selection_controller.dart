import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/error/api_exception.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/preference/model/preference_step_one_model.dart';

class TopicSelectionController extends GetxController {
  final RxSet<int> selectedIndexes = <int>{}.obs;
  final RxBool isSubmitting = false.obs;

  final ApiServices apiServices = ApiServices();

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  bool isSelected(int index) {
    return selectedIndexes.contains(index);
  }

  bool get hasSelection => selectedIndexes.isNotEmpty;

  Future<bool> selectedTopics(List<PreferenceStepOneModel> topics) async {
    if (selectedIndexes.isEmpty) return false;

    final List<String> selectedTopicCodes = selectedIndexes
        .map((index) => topics[index].topicCode)
        .toList();

    log('Selected topic codes: $selectedTopicCodes');

    try {
      isSubmitting.value = true;

      final response = await apiServices.post(
        '/api/v1/profiles/onboarding/step-1/',
        data: {'topic_codes': selectedTopicCodes},
        requireAuth: true,
      );

      log('Step-1 response: ${response.data}');

      final message =
          GetResponseMessage().getResponseMessage(response.data) ??
          'Preferences saved!';

      Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } on ApiException catch (e) {
      log('ApiException saving preferences: ${e.message} (${e.statusCode})');
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      log('Unexpected error saving preferences: $e');
      Get.snackbar(
        'Error',
        'Failed to save preferences. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}
