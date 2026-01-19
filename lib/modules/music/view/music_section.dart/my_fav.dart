import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/modules/music/widget/musicCardWidget.dart';

class MyFavTab extends StatelessWidget {
  const MyFavTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Column(
          children: [
            MusicCardWidget(isFav: true, isDvided: true),
            MusicCardWidget(isFav: true, isDvided: true),
            MusicCardWidget(isFav: true, isDvided: true),
            MusicCardWidget(isFav: true, isDvided: true),
            MusicCardWidget(isFav: true, isDvided: true),
            MusicCardWidget(isFav: true, isDvided: true),
            SizedBox(height: 30.h),
          ],
        ),
      ],
    );
  }
}
