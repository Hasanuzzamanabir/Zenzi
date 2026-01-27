import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/preference/view/preference_page.dart';

class AcoountCogratulationsPage extends StatelessWidget {
  const AcoountCogratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Center content
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image/auth/Successmark.png',
                      width: 150.w,
                      height: 150.h,
                    ),
                    SizedBox(height: 60.h),
                    Text(
                      'Congratulations!',
                      style: AppTextStyle.h1.copyWith(
                        color: AppColors.primarycolor,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      'Your account has been created \n successfully',
                      style: AppTextStyle.h3,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60.h),
                    AppButton(
                      title: 'Continue',
                      onTap: () {
                        Get.toNamed('/preferencePage');
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Back arrow button
            Positioned(
              left: 16,
              top: 0,
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back),
                color: AppColors.secondarycolor,
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
