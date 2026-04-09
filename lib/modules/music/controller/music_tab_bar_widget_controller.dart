import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';

class MusicTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;
  final MusicController musicController = Get.find<MusicController>();
  final ApiServices _apiServices = ApiServices();

  final RxList<String> selectedTabs = <String>['All', 'My'].obs;
  final RxList<_MusicTabFilter> _tabFilters = <_MusicTabFilter>[
    const _MusicTabFilter(title: 'All', categorySlug: '', onlyFavorites: false),
    const _MusicTabFilter(title: 'My', categorySlug: '', onlyFavorites: true),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTabsFromCategories();
  }

  Future<void> _loadTabsFromCategories() async {
    try {
      final response = await _apiServices.get(
        '/api/v1/content/categories/',
        requireAuth: true,
      );

      final List<dynamic> categoryList = _extractCategoryList(response.data);
      final List<_MusicTabFilter> dynamicTabs = <_MusicTabFilter>[
        const _MusicTabFilter(
          title: 'All',
          categorySlug: '',
          onlyFavorites: false,
        ),
        const _MusicTabFilter(
          title: 'My',
          categorySlug: '',
          onlyFavorites: true,
        ),
      ];

      for (final item in categoryList) {
        if (item is! Map<String, dynamic>) {
          continue;
        }

        final String name = (item['name'] ?? '').toString().trim();
        final String slug = (item['slug'] ?? '').toString().trim();
        if (name.isEmpty || slug.isEmpty) {
          continue;
        }

        dynamicTabs.add(
          _MusicTabFilter(
            title: name,
            categorySlug: slug,
            onlyFavorites: false,
          ),
        );
      }

      if (dynamicTabs.length <= 2) {
        return;
      }

      _tabFilters.assignAll(dynamicTabs);
      selectedTabs.assignAll(dynamicTabs.map((tab) => tab.title));

      if (selectedTabIndex.value >= _tabFilters.length) {
        selectedTabIndex.value = 0;
      }
    } catch (_) {
      // Keep default tabs if categories API fails.
    }
  }

  List<dynamic> _extractCategoryList(dynamic body) {
    if (body is List<dynamic>) {
      return body;
    }

    if (body is Map<String, dynamic>) {
      final dynamic data = body['data'];

      if (data is List<dynamic>) {
        return data;
      }

      if (data is Map<String, dynamic>) {
        final dynamic results = data['results'];
        if (results is List<dynamic>) {
          return results;
        }
      }

      final dynamic results = body['results'];
      if (results is List<dynamic>) {
        return results;
      }
    }

    return const <dynamic>[];
  }

  void selectTab(int index) {
    if (index < 0 || index >= _tabFilters.length) {
      return;
    }

    selectedTabIndex.value = index;
    final _MusicTabFilter selectedFilter = _tabFilters[index];
    musicController.applyTabFilter(
      categorySlug: selectedFilter.categorySlug,
      onlyFavorites: selectedFilter.onlyFavorites,
    );
  }

  bool selectTabByTitle(String title) {
    final normalizedTitle = title.trim().toLowerCase();
    if (normalizedTitle.isEmpty) {
      return false;
    }

    final int tabIndex = selectedTabs.indexWhere(
      (tab) => tab.trim().toLowerCase() == normalizedTitle,
    );

    if (tabIndex < 0) {
      return false;
    }

    selectTab(tabIndex);
    return true;
  }
}

class _MusicTabFilter {
  final String title;
  final String categorySlug;
  final bool onlyFavorites;

  const _MusicTabFilter({
    required this.title,
    required this.categorySlug,
    required this.onlyFavorites,
  });
}
