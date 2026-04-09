import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';
import 'package:zenzi/modules/music/widget/music_card_widget.dart';

class RelaxTab extends StatelessWidget {
  const RelaxTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MusicController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      // Filter for relax music (example: by title or other property)
      final relaxMusic = controller.musicList
          .where(
            (music) =>
                music.title.toLowerCase().contains('relax') ||
                music.title.toLowerCase().contains('ambient'),
          )
          .toList();
      if (relaxMusic.isEmpty) {
        return Column(
          children: [
            Text(
              'No relax music found',
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
        itemCount: relaxMusic.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final music = relaxMusic[index];
          return MusicCardWidget(music: music);
        },
      );
    });
  }
}
