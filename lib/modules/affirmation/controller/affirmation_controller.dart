import 'dart:developer';
import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/affirmation/model/affirmation_model.dart';

class AffirmationController extends GetxController {
  final ApiServices apiServices = ApiServices();
  
  var isLoading = false.obs;
  var hasError = false.obs;
  var affirmationList = <AffirmationModel>[].obs;
  var currentIndex = 0.obs;
  var totalCount = 0.obs;

  @override
  void onInit() {
    getAffirmations();
    super.onInit();
  }

  Future<void> getAffirmations() async {
    try {
      isLoading.value = true;
      hasError.value = false; // Reset error state before making the call

      final response = await apiServices.get(
        '/api/v1/content/affirmations/',
        requireAuth: true,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final dynamic responseBody = response.data['data']; 
        
        if (responseBody != null && responseBody['results'] != null) {
          final List rawList = responseBody['results'];
          totalCount.value = responseBody['count'] ?? 0;

          var list = rawList.map((json) => AffirmationModel.fromJson(json)).toList();
          affirmationList.assignAll(list);
          
          log("Affirmations fetched successfully: ${affirmationList.length} items");
          currentIndex.value = 0; 
        }
      } else {
        // Handle non-200 status codes or business logic failures
        hasError.value = true;
        log("Failed to fetch affirmations. Status: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network errors, timeouts, or parsing errors
      hasError.value = true;
      log("Error fetching/mapping data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(int? id, int index) async {
    if (id == null || index < 0 || index >= affirmationList.length) {
      log("Favorite Error: invalid id/index. id=$id, index=$index");
      return;
    }

    bool previousStatus = affirmationList[index].isFavorited ?? false;
    final String endpoint = '/api/v1/content/affirmations/$id/favorite/';
    
    try {
      // 1. Optimistically update UI
      affirmationList[index].isFavorited = !previousStatus;
      affirmationList.refresh(); 

      // 2. API Call
      log('Favorite POST -> endpoint: $endpoint, id: $id, index: $index, previous: $previousStatus, optimistic: ${affirmationList[index].isFavorited}');
      final response = await apiServices.post(
        endpoint,
        data: {}, 
        requireAuth: true,
      );
      log('Favorite POST <- status: ${response.statusCode}, body: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        // 3. Sync with server data
        affirmationList[index].isFavorited = response.data['data']['is_favorited'];
        affirmationList.refresh();
        log("Favorite Status: ${affirmationList[index].isFavorited}");
      } else {
        log('Favorite POST failed business check. Reverting to previous status.');
        affirmationList[index].isFavorited = previousStatus;
        affirmationList.refresh();
      }
    } catch (e) {
      log("Favorite Error: $e");
      affirmationList[index].isFavorited = previousStatus;
      affirmationList.refresh();
    }
  }

  void nextAffirmation() {
    if (currentIndex.value < affirmationList.length - 1) currentIndex.value++;
  }

  void previousAffirmation() {
    if (currentIndex.value > 0) currentIndex.value--;
  }
}