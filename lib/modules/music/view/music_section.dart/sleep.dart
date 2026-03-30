import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

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
