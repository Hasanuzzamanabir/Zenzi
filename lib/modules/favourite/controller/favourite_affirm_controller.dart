// import 'package:get/get.dart';
// import 'package:zenzi/core/network/services/api_services.dart';
// import 'package:zenzi/modules/favourite/model/favourite_affirmation_model.dart';

// class AffirmationController extends GetxController {
//   final ApiServices apiServices = ApiServices();

//   var isLoading = true.obs;
//   var affirmationList = <AffirmationModel>[].obs;

//   @override
//   void onInit() {
//     getAffirmations();
//     super.onInit();
//   }

//   Future<void> getAffirmations() async {
//     try {
//       isLoading(true);

//       final response = await apiServices.get(
//         '/api/v1/content/favorites/affirmations/',
//       );

//       if (response.statusCode == 200) {
//         final List data = response.data['results'];
//         affirmationList.assignAll(
//           data.map((e) => AffirmationModel.fromJson(e)).toList(),
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/favourite/model/favourite_affirmation_model.dart';

class FavouriteAffirmController extends GetxController {
  final ApiServices apiServices = ApiServices();

  var isLoading = true.obs;
  var affirmationList = <AffirmationModel>[].obs;

  @override
  void onInit() {
    getAffirmations();
    super.onInit();
  }

Future<void> getAffirmations() async {
  try {
    isLoading(true);

    final response = await apiServices.get(
      '/api/v1/content/favorites/affirmations/',
       requireAuth: true
    );

    if (response.statusCode == 200 && response.data != null) {

      final List? dataList = response.data['data']['results'];
      
      if (dataList != null) {
        affirmationList.assignAll(
          dataList.map((e) => AffirmationModel.fromJson(e)).toList(),
        );
        print("Data loaded successfully: ${affirmationList.length}");
      } else {
        affirmationList.clear();
      }
    }
  } catch (e) {
    print("Affirmation API Error: $e");
  } finally {
    isLoading(false);
  }
}
}