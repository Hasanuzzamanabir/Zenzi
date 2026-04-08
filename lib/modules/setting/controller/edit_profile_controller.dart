import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:zenzi/core/network/error/api_exception.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/setting/model/edit_profile_model.dart';

class EditProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  Rx<EditProfileModel?> profile = Rxn<EditProfileModel>();

  final ApiServices apiServices = ApiServices();

  /// Fetch current profile data from the server.
  Future<EditProfileModel?> fetchProfile() async {
    try {
      isLoading.value = true;
      final response = await apiServices.get(
        '/api/v1/profiles/personal-info/',
        requireAuth: true,
      );
      log('fetchProfile response: ${response.data}');
      final data = EditProfileModel.fromJson(response.data['data']);
      return profile.value = data;
    } catch (e) {
      log('Unexpected error fetchProfile: $e');
      Get.snackbar('Error', 'Failed to load profile. Please try again.');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Update profile on the server.
  Future<bool> updateProfile(
    String name,
    String email,
    String phoneNumber,
    String dateOfBirth,
    String gender,
    File? avatar,
  ) async {
    try {
      isSubmitting.value = true;

      final formData = dio.FormData.fromMap({
        'name': name,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth,
        'gender': gender.toUpperCase(),
        if (avatar != null)
          'avatar': await dio.MultipartFile.fromFile(
            avatar.path,
            filename: avatar.path.split('/').last,
          ),
      });

      log('updateProfile payload: $formData');

      final response = await apiServices.patch(
        '/api/v1/profiles/personal-info/',
        requireAuth: true,
        data: formData,
      );

      log('updateProfile response: ${response.data}');

      final body = response.data;
      final isSuccess = body is Map && body['success'] == true;

      final message = isSuccess
          ? ((body['message']?.toString().trim().isNotEmpty ?? false)
                ? body['message'].toString()
                : 'Profile updated successfully.')
          : GetResponseMessage().getResponseMessage(body);

      Get.snackbar(isSuccess ? 'Success' : 'Error', message);
      return isSuccess;
    } on ApiException catch (e) {
      log('ApiException updateProfile: ${e.message} (${e.statusCode})');
      Get.snackbar('Error', e.message);
      return false;
    } catch (e) {
      log('Unexpected error updateProfile: $e');
      Get.snackbar('Error', 'Failed to update profile. Please try again.');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}
