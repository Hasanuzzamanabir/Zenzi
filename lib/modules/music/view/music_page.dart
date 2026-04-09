import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/bottom_navigation_bar/controller/custom_bottom_navigation_bar_controller.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';
import 'package:zenzi/modules/music/controller/music_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/music/widget/music_tab_bar_widget.dart';
import 'package:zenzi/modules/music/widget/music_tab_bar_widget_view.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final musicController = Get.put(MusicController());
  final tabController = Get.put(MusicTabBarWidgetController());

  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchTextController = TextEditingController();
  Worker? _tabsWorker;
  String? _pendingInitialTabTitle;

  void _applyInitialTabSelection() {
    final arguments = Get.arguments;

    if (arguments is Map) {
      final dynamic initialTabTitle = arguments['initialTabTitle'];
      if (initialTabTitle is String && initialTabTitle.trim().isNotEmpty) {
        _pendingInitialTabTitle = initialTabTitle.trim();
      }

      final dynamic initialIndexValue = arguments['initialIndex'];
      if (initialIndexValue is int &&
          initialIndexValue >= 0 &&
          initialIndexValue < tabController.selectedTabs.length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          tabController.selectTab(initialIndexValue);
        });
      }
    }

    if (Get.isRegistered<CustomBottomNavigationBarController>()) {
      final navController = Get.find<CustomBottomNavigationBarController>();
      final requestedTabTitle = navController
          .consumeRequestedMusicTabSelection();
      if (requestedTabTitle != null && requestedTabTitle.trim().isNotEmpty) {
        _pendingInitialTabTitle = requestedTabTitle.trim();
      }
    }

    _trySelectPendingTabByTitle();
    _tabsWorker ??= ever<List<String>>(tabController.selectedTabs, (_) {
      _trySelectPendingTabByTitle();
    });
  }

  void _trySelectPendingTabByTitle() {
    final tabTitle = _pendingInitialTabTitle;
    if (tabTitle == null || tabTitle.isEmpty) {
      return;
    }

    final bool selected = tabController.selectTabByTitle(tabTitle);
    if (selected) {
      _pendingInitialTabTitle = null;
      _tabsWorker?.dispose();
      _tabsWorker = null;
    }
  }

  @override
  void initState() {
    super.initState();

    _applyInitialTabSelection();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _tabsWorker?.dispose();
    searchFocusNode.unfocus();
    searchFocusNode.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ThemedScaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCC8855),
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 160.h,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.appBarGradientColors,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Music", style: AppTextStyle.h8),
                SizedBox(height: 15.h),
                TextField(
                  controller: searchTextController,
                  focusNode: searchFocusNode,
                  onChanged: musicController.onSearchChanged,
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search Music...',
                    hintStyle: TextStyle(
                      color: AppColors.searchtextcolor,
                      fontSize: 14.sp,
                    ),
                    filled: true,
                    fillColor: AppColors.secondarycolor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.searchtextcolor,
                      size: 20.w,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.primarydarker,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                MusicTabBarWidget(),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(child: MusicTabBarWidgetView()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
