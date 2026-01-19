import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/music/controller/audio_player_controller.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = Get.find<AudioPlayerController>();

    return GestureDetector(
      onTap: () => audioController.togglePlayPause(),
      child: Obx(
        () => Container(
          width: 88.w,
          height: 88.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.playbuttoncolor1.withOpacity(
              0.18,
            ), // soft outer circle
          ),
          child: Container(
            width: 72.w,
            height: 72.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.playbuttoncolor1,
            ),
            child: Center(
              child: Icon(
                audioController.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.white,
                size: 32.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
