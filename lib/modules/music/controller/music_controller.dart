import 'package:get/get.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/data/models/music_model.dart';
import 'package:zenzi/modules/music/model/audio_track_model.dart';

class MusicController extends GetxController {
  final ApiServices apiServices = ApiServices();

  var musicList = <MusicModel>[].obs;
  var isLoading = true.obs;
  final searchQuery = ''.obs;
  final selectedCategorySlug = ''.obs;
  final favoritesOnly = false.obs;

  late final Worker _searchDebounceWorker;

  @override
  void onInit() {
    super.onInit();
    _searchDebounceWorker = debounce<String>(
      searchQuery,
      (_) => fetchMusic(showLoader: false),
      time: const Duration(milliseconds: 400),
    );
    fetchMusic();
  }

  @override
  void onClose() {
    _searchDebounceWorker.dispose();
    super.onClose();
  }

  Future<void> fetchMusic({bool showLoader = true}) async {
    try {
      if (showLoader) {
        isLoading(true);
      }

      final Map<String, dynamic> queryParams = {};
      final String trimmedSearch = searchQuery.value.trim();
      final String trimmedCategory = selectedCategorySlug.value.trim();

      if (trimmedSearch.isNotEmpty) {
        queryParams['search'] = trimmedSearch;
      }
      if (trimmedCategory.isNotEmpty) {
        queryParams['category__slug'] = trimmedCategory;
      }
      if (favoritesOnly.value) {
        queryParams['favorites_only'] = true;
      }

      final response = await apiServices.get(
        '/api/v1/content/audio-tracks/',
        queryParameters: queryParams.isEmpty ? null : queryParams,
        requireAuth: true,
      );

      final body = response.data;
      final List<dynamic> dataList =
          (body['data']?['results'] as List<dynamic>? ?? <dynamic>[]);

      final tracks = dataList
          .map((item) {
            final map = item as Map<String, dynamic>;
            final audioTrack = AudioTrackModel.fromJson(map);
            final String resolvedAudioUrl = _resolveMediaUrl(
              audioTrack.mediaFile,
            );
            final String subtitle = audioTrack.subtitle.trim().isNotEmpty
                ? audioTrack.subtitle.trim()
                : audioTrack.category.name.trim();

            return MusicModel(
              id: audioTrack.id.toString(),
              title: audioTrack.title,
              subtitle: subtitle,
              duration: _formatDuration(audioTrack.durationMinutes),
              audioUrl: resolvedAudioUrl,
              imageUrl: (map['thumbnail'] ?? map['image'] ?? '').toString(),
            );
          })
          .where((track) => track.audioUrl.isNotEmpty)
          .toList();

      musicList.assignAll(tracks);
    } catch (_) {
      musicList.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> applyTabFilter({
    required String categorySlug,
    required bool onlyFavorites,
  }) async {
    selectedCategorySlug.value = categorySlug;
    favoritesOnly.value = onlyFavorites;
    await fetchMusic(showLoader: true);
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  String _formatDuration(int durationMinutes) {
    final int safeMinutes = durationMinutes < 0 ? 0 : durationMinutes;
    final int hours = safeMinutes ~/ 60;
    final int minutes = safeMinutes % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00';
    }

    return '${minutes.toString().padLeft(2, '0')}:00';
  }

  String _resolveMediaUrl(String rawUrl) {
    final String trimmed = rawUrl.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    final Uri? parsed = Uri.tryParse(trimmed);
    if (parsed != null && parsed.hasScheme) {
      return parsed.toString();
    }

    final String normalizedPath = trimmed.startsWith('/')
        ? trimmed
        : '/$trimmed';
    final String absoluteUrl = '${BaseUrl.baseUrl}$normalizedPath';
    return Uri.tryParse(absoluteUrl)?.toString() ?? '';
  }
}
