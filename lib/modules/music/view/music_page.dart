import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/music/controller/music_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/music/widget/music_tab_bar_widget.dart';
import 'package:zenzi/modules/music/widget/music_tab_bar_widget_view.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MusicTabBarWidgetController());

    return Scaffold(
      backgroundColor: AppColors.primarydarker,
      appBar: AppBar(
        backgroundColor: const Color(0xFFCC8855),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 160.h,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.appbarcolorone, AppColors.appbarcolortwo],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Music", style: AppTextStyle.h8),
              SizedBox(height: 15.h),
              TextField(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
    );
  }
}
