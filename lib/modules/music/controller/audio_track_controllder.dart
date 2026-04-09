import 'dart:developer';
import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/music/model/audio_track_model.dart';

class AudioTrackController extends GetxController {
  final ApiServices apiServices = ApiServices();

  var isLoading = true.obs;
  var audioList = <AudioTrackModel>[].obs;

  @override
  void onInit() {
    getAudioTracks();
    super.onInit();
  }

  Future<void> getAudioTracks() async {
    try {
      isLoading.value = true;

      final response = await apiServices.get(
        '/api/v1/content/audio-tracks/',
        requireAuth: true,
      );

      final body = response.data;
      log("Audio Track API Response: $body");

      final List dataList = body['data']['results'];

      audioList.clear();

      audioList.addAll(
        dataList.map((e) => AudioTrackModel.fromJson(e)).toList(),
      );

      log("Audio loaded successfully: ${audioList.length}");
    } catch (e) {
      log("Audio API Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
