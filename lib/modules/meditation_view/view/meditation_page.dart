import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/meditation_view/widget/custom_tab_bar_widget.dart';
import 'package:zenzi/modules/meditation_view/widget/custom_tab_bar_widget_view.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180.h),
        child: AppBar(
          backgroundColor: const Color(0xFFCC8855),
          elevation: 0,
          automaticallyImplyLeading: false,

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
                const Text("Meditation Library", style: AppTextStyle.h8),
                SizedBox(height: 15.h),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search meditations...',
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
      ),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomTabBarWidget(),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(child: CustomTabBarWidgetView()),
            ),
          ],
        ),
      ),
    );
  }
}
