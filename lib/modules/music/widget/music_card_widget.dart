import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/data/models/music_model.dart';
import 'package:zenzi/modules/music/controller/audio_player_controller.dart';
import 'package:zenzi/modules/music/view/play_music.dart';

class MusicCardWidget extends StatelessWidget {
  final MusicModel music;
  final bool isFav;
  final bool isDivided;

  const MusicCardWidget({
    super.key,
    required this.music,
    this.isFav = false,
    this.isDivided = false,
  });

  @override
  Widget build(BuildContext context) {
    final audioController = Get.find<AudioPlayerController>();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            audioController.playMusic(music);
            Get.to(() => PlayMusic());
          },
          child: ListTile(
            leading: GestureDetector(
              onTap: () => audioController.playMusic(music),
              child: Obx(() {
                final isCurrent =
                    audioController.currentMusic.value?.id == music.id;
                final isPlaying = isCurrent && audioController.isPlaying.value;
                return Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: isCurrent ? AppColors.playbuttoncolor1 : null,
                    border: Border.all(color: AppColors.secondarycolor),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                );
              }),
            ),
            title: Text(
              music.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              music.duration,
              style: TextStyle(color: Colors.white70),
            ),
            trailing: Icon(isFav ? Icons.favorite : null, color: Colors.red),
          ),
        ),
        if (isDivided) Divider(),
      ],
    );
  }
}
