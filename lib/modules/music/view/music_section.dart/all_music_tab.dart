import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/modules/music/widget/musicCardWidget.dart';

class AllMusicTab extends StatelessWidget {
  const AllMusicTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Column(
          children: [
            MusicCardWidget(isDvided: true),
            MusicCardWidget(isDvided: true),
            MusicCardWidget(isDvided: true),
            MusicCardWidget(isDvided: true),
            MusicCardWidget(isDvided: true),
            MusicCardWidget(isDvided: true),
            MusicCardWidget(isDvided: true),
            MusicCardWidget(isDvided: true),
            MusicCardWidget(),

            // MusicCardWidget(isFav: true),
            SizedBox(height: 30.h),
          ],
        ),
      ],
    );
  }
}
