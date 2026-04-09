import 'dart:developer';

import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/favourite/model/favourite_affirmation_model.dart';

class FavouriteAffirmController extends GetxController {
  final ApiServices apiServices = ApiServices();

  var isLoading = true.obs;
  var affirmationList = <AffirmationModel>[].obs;
  var favouriteCount = [].obs;

  @override
  void onInit() {
    getAffirmations();
    super.onInit();
  }

  Future<void> getAffirmations() async {
    try {
      isLoading.value = true;

      final response = await apiServices.get(
        '/api/v1/content/favorites/affirmations/',
        requireAuth: true,
      );
      final body = response.data;
      log("Affirmation API Response: $body");
      final List dataList = body['data']['results'];

      affirmationList.addAll(
        dataList.map((e) => AffirmationModel.fromJson(e)).toList(),
      );

      favouriteCount.addAll(affirmationList);

      log("Data loaded successfully: ${affirmationList.length}");
    } catch (e) {
      log("Affirmation API Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
