import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/modules/download/widgets/music_download_card.dart';

class DownloadMusicPage extends StatelessWidget {
  const DownloadMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Column(
          children: [
            MusicDownloadCardWidget(),
            MusicDownloadCardWidget(),
            MusicDownloadCardWidget(),
            MusicDownloadCardWidget(),

            SizedBox(height: 30.h),
          ],
        ),
      ],
    );
  }
}
