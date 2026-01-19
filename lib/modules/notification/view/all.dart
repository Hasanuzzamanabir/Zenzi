import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/notification/widgets/notification_card_widget.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Column(
          children: [
            NotificationCardWidget(
              image: AppAssets.notifySun,
              title: 'Morning Affirmation Ready',
              description:
                  'Your daily affirmation is here. Start your day with intention.',
              time: '2 hours ago',
              style: TextStyle(color: AppColors.navbackground),
            ),
            NotificationCardWidget(
              image: AppAssets.notification2,
              title: 'Morning Affirmation Ready',
              description:
                  'Your daily affirmation is here. Start your day with intention.',
              time: '2 hours ago',
              style: TextStyle(color: AppColors.navbackground),
            ),
            NotificationCardWidget(
              backgroundColor: AppColors.secondarycolor,
              image: AppAssets.notification3,
              title: 'Morning Affirmation Ready',
              style: TextStyle(color: AppColors.navbackground),
              description:
                  'Your daily affirmation is here. Start your day with intention.',
              time: '2 hours ago',
            ),

            // MusicCardWidget(isFav: true),
            SizedBox(height: 30.h),
          ],
        ),
      ],
    );
  }
}
