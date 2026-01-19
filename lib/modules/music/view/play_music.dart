import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/music/widget/control_icon.dart';
import 'package:zenzi/modules/music/widget/play_pause_button_widget.dart';
import 'package:zenzi/modules/music/widget/top_action_icon.dart';

class PlayMusic extends StatelessWidget {
  const PlayMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌈 Background
          Positioned.fill(
            child: Image.asset(AppAssets.musicplay, fit: BoxFit.cover),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  /// 🔝 Top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      ),
                      Row(
                        children: [
                          TopActionIcon(icon: Icons.favorite_border),
                          SizedBox(width: 10.w),
                          TopActionIcon(icon: Icons.file_download_outlined),
                        ],
                      ),
                    ],
                  ),

                  Spacer(),

                  /// 🧠 Title
                  Text(
                    'Focus Attention',
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '7 DAYS OF CALM',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                      color: Color(0xFFA0A3B1),
                    ),
                  ),

                  SizedBox(height: 90.h),

                  /// 🎛 Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ControlIcon(),
                      SizedBox(width: 24.w),
                      Container(child: PlayPauseButton()),
                      SizedBox(width: 24.w),
                      ControlIcon(isForward: true),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  /// 🎚 Slider
                  Slider(
                    value: 90,
                    min: 0,
                    max: 2700,
                    onChanged: (_) {},
                    activeColor: const Color(0xFFD9A15F),
                    inactiveColor: const Color(0xFFD9A15F).withOpacity(0.3),
                  ),

                  /// ⏰ Time
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '01:30',
                          style: TextStyle(
                            color: AppColors.navbackground,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '45:00',
                          style: TextStyle(
                            color: AppColors.navbackground,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
