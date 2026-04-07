import 'dart:developer';
import 'dart:io';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';

class EditProfileController extends GetxController {
  final ApiServices apiServices = ApiServices();
  var isLoading = false.obs;
  var isUpdating = false.obs;


 
  Future<bool> fetchProfile(
    String name, String email, String phoneNumber, String dateOfBirth, String gender, File avatarPath
  ) async {
    try {
      isLoading.value = true;
     
      final response = await apiServices.get(
        '/api/v1/profiles/personal-info/',
        requireAuth: true,
        queryParameters: {
          "name": name,
          "email": email,
          "phone_number": phoneNumber,
          "date_of_birth": dateOfBirth,
          "gender": gender,
        "avatar": MultipartFile(File(avatarPath.path), filename: avatarPath.path.split('/').last),
          
          }
      );

      final body = response.data;
      log("Response body: $body");

      final message = GetResponseMessage().getResponseMessage(body);
      Get.snackbar("Success", message);
      return true;
    } catch (e) {
      log("Error fetching profile: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
 
  

}