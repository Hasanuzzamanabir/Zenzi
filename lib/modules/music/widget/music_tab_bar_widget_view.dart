import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';
import 'package:zenzi/modules/music/controller/music_tab_bar_widget_controller.dart';
import 'package:zenzi/modules/music/widget/music_card_widget.dart';

class MusicTabBarWidgetView extends StatelessWidget {
  const MusicTabBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = Get.find<MusicTabBarWidgetController>();
    final musicController = Get.find<MusicController>();

    return Obx(() {
      if (musicController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (musicController.musicList.isEmpty) {
        final bool isFavoritesTab = tabController.selectedTabIndex.value == 1;
        return Center(
          child: Text(
            isFavoritesTab ? 'No favorites found' : 'No music found',
            style: const TextStyle(color: Colors.white),
          ),
        );
      }

      return Column(
        children: [
          SizedBox(height: 20.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: musicController.musicList.length,
            itemBuilder: (context, index) {
              final music = musicController.musicList[index];
              final bool isFavoritesTab =
                  tabController.selectedTabIndex.value == 1;

              return MusicCardWidget(
                music: music,
                isFav: isFavoritesTab,
                isDivided: index != musicController.musicList.length - 1,
              );
            },
          ),
          SizedBox(height: 30.h),
        ],
      );
    });
  }
}
