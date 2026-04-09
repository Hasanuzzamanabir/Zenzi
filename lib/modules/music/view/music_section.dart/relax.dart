import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

      if (controller.musicList.isEmpty) {
        return const Center(
          child: Text(
            'No relax music found',
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      return Column(
        children: [
          SizedBox(height: 20.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.musicList.length,
            itemBuilder: (context, index) {
              final music = controller.musicList[index];
              return MusicCardWidget(
                music: music,
                isDivided: index != controller.musicList.length - 1,
              );
            },
          ),
          SizedBox(height: 30.h),
        ],
      );
    });
  }
}
