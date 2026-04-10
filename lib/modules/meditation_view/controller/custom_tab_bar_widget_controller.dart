import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/meditation_view/controller/meditation_controller.dart';

class CustomTabBarWidgetController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;
  final ApiServices _apiServices = ApiServices();
  late final MeditationController _meditationController;

  final RxList<String> selectedTabs = <String>[].obs;
  final RxList<MeditationTabFilter> _tabFilters = <MeditationTabFilter>[].obs;

  @override
  void onInit() {
    super.onInit();
    _meditationController = Get.find<MeditationController>();
    _initializeTabs();
  }

  Future<void> _initializeTabs() async {
    final List<MeditationTabFilter> defaultTabs = <MeditationTabFilter>[
      const MeditationTabFilter(title: 'All', categorySlug: ''),
    ];

    try {
      final response = await _apiServices.get(
        '/api/v1/content/categories/',
        requireAuth: true,
      );

      final List<dynamic> categoryList = _extractCategoryList(response.data);
      final List<MeditationTabFilter> dynamicTabs = <MeditationTabFilter>[
        ...defaultTabs,
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

        dynamicTabs.add(MeditationTabFilter(title: name, categorySlug: slug));
      }

      _tabFilters.assignAll(dynamicTabs);
      selectedTabs.assignAll(dynamicTabs.map((tab) => tab.title));
    } catch (_) {
      // Keep default tabs if categories API fails
      _tabFilters.assignAll(defaultTabs);
      selectedTabs.assignAll(defaultTabs.map((tab) => tab.title));
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
    final MeditationTabFilter selectedFilter = _tabFilters[index];
    _meditationController.applyTabFilter(
      categorySlug: selectedFilter.categorySlug,
    );
  }
}

class MeditationTabFilter {
  final String title;
  final String categorySlug;

  const MeditationTabFilter({required this.title, required this.categorySlug});
}
