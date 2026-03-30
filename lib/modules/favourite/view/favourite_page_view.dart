import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/favourite/widgets/favourite_tab_bar_widget.dart';
import 'package:zenzi/modules/favourite/widgets/favourite_tab_bar_widget_view.dart';
import 'package:zenzi/modules/music/controller/audio_player_controller.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';

class FavouritePageView extends StatelessWidget {
  const FavouritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MusicController());
    Get.put(AudioPlayerController());
    //final controller = Get.put(FavouriteTabBarWidgetController());

    return ThemedScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.secondarycolor,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Favourites",
                      style: AppTextStyle.h4.copyWith(
                        color: AppColors.primarytext,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            FavouriteTabBarWidget(),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(child: FavouriteTabBarWidgetView()),
            ),
          ],
        ),
      ),
    );
  }
}
