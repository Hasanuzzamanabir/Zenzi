import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/affirmation/model/affirmation_model.dart';

// class AffirmationController extends GetxController {
//   final ApiServices apiServices = ApiServices();
//   var isLoading = false.obs;
//   var affirmationList = <AffirmationModel>[].obs;
//   var currentIndex = 0.obs;

//   @override
//   void onInit() {
//     getAffirmations();
//     super.onInit();
//   }

//   Future<void> getAffirmations() async {
//     try {
//       isLoading.value = true;
//       final response = await apiServices.get(
//         '/api/v1/content/affirmations/',
//         requireAuth: true,
//       );
//       if (response.statusCode == 200) {
//         final List data = response.data['results'];
//         if(data != null && data is List) {
//             affirmationList.assignAll(
//             data.map((json) => AffirmationModel.fromJson(json)).toList());
//           log("Affirmations fetched successfully: ${data.length} items");
//         } else {
//           log("Warning: 'results' key is null or not a list");
//         affirmationList.clear();
//         }
      
//       } else {
//         log("Failed to fetch affirmations: ${response.statusCode}");
//       }
//     } catch (e) {
//       log("Error fetching affirmations: $e");
//       Get.snackbar("Error", "Failed to load affirmations.");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void nextAffirmation() {
//     if (currentIndex.value < affirmationList.length - 1) {
//       currentIndex.value++;
//     } else {
//       Get.snackbar("End", "You have reached the end.");
//     }
//   }

//   void previousAffirmation() {
//     if (currentIndex.value > 0) {
//       currentIndex.value--;
//     }
//   }
// }
import 'dart:developer';
import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/affirmation/model/affirmation_model.dart';

class AffirmationController extends GetxController {
  final ApiServices apiServices = ApiServices();
  
  var isLoading = false.obs;
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
    final response = await apiServices.get(
      '/api/v1/content/affirmations/',
      requireAuth: true,
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      final dynamic responseBody = response.data['data']; 
      debugPrint(  "Raw Response Body: $responseBody");
      
      if (responseBody != null && responseBody['results'] != null) {
        final List rawList = responseBody['results'];
        totalCount.value = responseBody['count'] ?? 0;


        var list = rawList.map((json) => AffirmationModel.fromJson(json)).toList();
        affirmationList.assignAll(list);
        
        log("Affirmations fetched successfully: ${affirmationList.length} items");
        currentIndex.value = 0; 
      }
    }
  } catch (e) {
    print("Error mapping data: $e");
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
    // আগের স্ট্যাটাস সেভ করে রাখা যাতে এরর হলে রিভার্ট করা যায়

    // ১. লোকালি আইকন দ্রুত পরিবর্তন করা
    affirmationList[index].isFavorited = !previousStatus;
    affirmationList.refresh(); 

    // ২. পোস্ট মেথড হিট করা
    log('Favorite POST -> endpoint: $endpoint, id: $id, index: $index, previous: $previousStatus, optimistic: ${affirmationList[index].isFavorited}');
    final response = await apiServices.post(
      endpoint,
      data: {}, // এম্পটি বডি
      requireAuth: true,
    );
    log('Favorite POST <- status: ${response.statusCode}, body: ${response.data}');

    if (response.statusCode == 200 && response.data['success'] == true) {
      // ৩. সার্ভার থেকে আসা ডাটা অনুযায়ী আপডেট (ইমেজ অনুযায়ী path: data -> is_favorited)
      affirmationList[index].isFavorited = response.data['data']['is_favorited'];
      affirmationList.refresh();
      log("Favorite Status: ${affirmationList[index].isFavorited}");
    } else {
      log('Favorite POST failed business check. Reverting to previous status.');
      // সার্ভারে সমস্যা হলে আগের অবস্থায় ফেরত যাওয়া
      affirmationList[index].isFavorited = previousStatus;
      affirmationList.refresh();
    }
  } catch (e) {
    log("Favorite Error: $e");
    // এক্সেপশন হলেও আগের অবস্থায় ফেরত নেওয়া
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