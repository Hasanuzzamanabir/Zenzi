import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/meditation_view/model/meditations_model.dart';

class MeditationController extends GetxController {
  final ApiServices apiServices = ApiServices();

  final meditationList = <MeditationsModel>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMeditations();
  }

  Future<void> fetchMeditations({bool showLoader = true}) async {
    try {
      if (showLoader) {
        isLoading.value = true;
      }

      hasError.value = false;

      final response = await apiServices.get(
        '/api/v1/content/meditations/',
        requireAuth: true,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final dynamic data = response.data['data'];
        final List<dynamic> rawList =
            data?['results'] as List<dynamic>? ?? <dynamic>[];

        final meditations = rawList
            .map(
              (item) => MeditationsModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();

        meditationList.assignAll(meditations);
        log('Meditations fetched successfully: ${meditationList.length} items');
      } else {
        hasError.value = true;
        meditationList.clear();
        log('Failed to fetch meditations. Status: ${response.statusCode}');
      }
    } catch (e) {
      hasError.value = true;
      meditationList.clear();
      log('Error fetching meditations: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  List<MeditationsModel> get filteredMeditations {
    final String query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return meditationList;
    }

    return meditationList
        .where(
          (meditation) =>
              meditation.title.toLowerCase().contains(query) ||
              meditation.description.toLowerCase().contains(query),
        )
        .toList();
  }
}
