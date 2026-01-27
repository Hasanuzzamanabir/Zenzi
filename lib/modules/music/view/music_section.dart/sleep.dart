import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/music/controller/music_controller.dart';
import 'package:zenzi/modules/music/widget/musicCardWidget.dart';

class SleepTab extends StatelessWidget {
  const SleepTab({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<MusicController>();

    return Column(
      children: [
        Text(
          'no music here  ',
          style: AppTextStyle.button.copyWith(color: AppColors.componentnormal),
        ),
      ],
    );
  }
}
