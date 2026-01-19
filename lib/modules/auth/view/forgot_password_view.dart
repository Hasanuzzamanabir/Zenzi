import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/modules/auth/view/otp_verification.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: SafeArea(
        child: Stack(
          children: [
            // Center content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    Image.asset(AppAssets.forgot, width: 150.w, height: 150.h),
                    SizedBox(height: 15.h),

                    /// 🧾 Title
                    Text('Forgot your Password ?', style: AppTextStyle.h2),
                    SizedBox(height: 10.h),
                    Text(
                      'Enter the email address associated \n with your account and we will \n send you OTP ',
                      style: AppTextStyle.h5.copyWith(
                        color: AppColors.secondarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 13.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: AppTextStyle.h5.copyWith(
                          color: AppColors.primarytext,
                        ),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    AppTextField(
                      hintText: 'Enter your email',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 30.h),
                    AppButton(
                      title: 'Send',
                      onTap: () {
                        Get.to(const OtpVerification(isSigning: false));
                      },
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'Back to Login',
                      style: AppTextStyle.h5.copyWith(
                        color: AppColors.skysunrise,
                      ),
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
