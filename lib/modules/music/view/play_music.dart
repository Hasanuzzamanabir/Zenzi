import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/music/controller/audio_player_controller.dart';
import 'package:zenzi/modules/music/widget/control_icon.dart';
import 'package:zenzi/modules/music/widget/play_pause_button_widget.dart';
import 'package:zenzi/modules/music/widget/top_action_icon.dart';

class PlayMusic extends StatelessWidget {
  const PlayMusic({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = Get.find<AudioPlayerController>();

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
              child: Obx(() {
                final music = audioController.currentMusic.value;
                if (music == null) {
                  return const Center(child: Text("No music selected"));
                }

                return Column(
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
                      music.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      music.subtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5,
                        color: const Color(0xFFA0A3B1),
                      ),
                    ),

                    SizedBox(height: 90.h),

                    /// 🎛 Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ControlIcon(),
                        SizedBox(width: 24.w),
                        PlayPauseButton(),
                        SizedBox(width: 24.w),
                        ControlIcon(isForward: true),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    /// 🎚 Slider
                    Slider(
                      value: audioController.position.value.inSeconds
                          .toDouble(),
                      min: 0,
                      max:
                          audioController.duration.value.inSeconds.toDouble() >
                              0
                          ? audioController.duration.value.inSeconds.toDouble()
                          : 1.0,
                      onChanged: (value) {
                        audioController.seek(Duration(seconds: value.toInt()));
                      },
                      activeColor: const Color(0xFFD9A15F),
                      inactiveColor: const Color(0xFFD9A15F).withOpacity(0.3),
                    ),

                    /// ⏰ Time
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(audioController.position.value),
                            style: const TextStyle(
                              color: AppColors.navbackground,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            _formatDuration(audioController.duration.value),
                            style: const TextStyle(
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
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
