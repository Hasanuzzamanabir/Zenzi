import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/modules/auth/view/acoount_cogratulations_Page.dart';
import 'package:zenzi/modules/auth/view/new%20password/view/new_password.dart';
//import 'package:zenzi/modules/auth/view/view/view/acoount_cogratulations_Page.dart';

enum Otpsource { signing, forgetpassword }

class OtpVerification extends StatefulWidget {
  const OtpVerification({
    super.key,
    this.email,
    this.source,
    this.isSigning = true,
  });

  final String? email;
  final Otpsource? source;
  final bool isSigning;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 Scrollable content
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),

                  /// 🖼 Illustration
                  Image.asset(
                    AppAssets.loginBg,
                    width: 260.w,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 20.h),

                  /// 🧾 Title
                  Text('OTP Verification', style: AppTextStyle.h2),

                  SizedBox(height: 10.h),

                  /// 📩 Subtitle
                  Text(
                    'Enter the OTP sent to your Email',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.secondarycolor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 6.h),

                  /// 📧 Email
                  Text(
                    widget.email ?? '',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                    ),
                  ),

                  SizedBox(height: 18.h),

                  /// 🔢 OTP Input
                  Pinput(
                    length: 5,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 52.w,
                      height: 52.h,
                      textStyle: AppTextStyle.h4.copyWith(
                        color: AppColors.backgroundcolor,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondarycolor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.backgroundbasecolor,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// 🔁 Resend OTP
                  RichText(
                    text: TextSpan(
                      text: "OTP not Received ?",
                      style: AppTextStyle.h3,
                      children: [
                        TextSpan(
                          text: ' Resend OTP',
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.primarycolor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  /// ✅ Verify Button (UP POSITION)
                  AppButton(
                    title: 'Verify',
                    onTap: () {
                      if (widget.isSigning) {
                        Get.to(const AcoountCogratulationsPage());
                      } else {
                        Get.to(const NewPasswordView());
                      }
                    },
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),

            /// 🔙 Back Button (fixed)
            Positioned(
              left: 8.w,
              top: 0,
              child: IconButton(
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
