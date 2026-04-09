import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';
import 'package:zenzi/modules/music/widget/music_card_widget.dart';

class HealingTab extends StatelessWidget {
  const HealingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MusicController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      // Filter for healing music (example: by title or other property)
      final healingMusic = controller.musicList
          .where(
            (music) =>
                music.title.toLowerCase().contains('peace') ||
                music.title.toLowerCase().contains('healing'),
          )
          .toList();
      if (healingMusic.isEmpty) {
        return Column(
          children: [
            Text(
              'No healing music found',
              style: AppTextStyle.button.copyWith(
                color: AppColors.componentnormal,
              ),
            ),
          ],
        );
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: healingMusic.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final music = healingMusic[index];
          return MusicCardWidget(music: music);
        },
      );
    });
  }
}
