import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/modules/auth/view/acoount_cogratulations_page.dart';
import 'package:zenzi/modules/auth/view/new%20password/view/new_password.dart';
import 'package:zenzi/modules/auth/view/otp/controller/otp_verification_controller.dart';
//import 'package:zenzi/modules/auth/view/view/view/acoount_cogratulations_Page.dart';

enum Otpsource { signin, forgetpassword }

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key, this.email, this.source});

  final String? email;
  final Otpsource? source;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController otpController = TextEditingController();

  final OtpVerificationController controller = Get.put(
    OtpVerificationController(),
  );

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

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
                    controller: otpController,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("OTP not Received ?  ", style: AppTextStyle.h3),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            otpController.clear();
                            controller.resendOtp(
                              isForgotPassword:
                                  widget.source == Otpsource.forgetpassword,
                              email: widget.email?.trim(),
                            );
                          },
                          child: controller.isOtpLoading.value
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primarycolor,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  "Resend OTP",
                                  style: AppTextStyle.h3.copyWith(
                                    color: AppColors.primarycolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  /// ✅ Verify Button (UP POSITION)
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: otpController,
                    builder: (context, value, child) {
                      final isOtpComplete = value.text.trim().length == 5;

                      return Obx(
                        () => AppButton(
                          title: 'Verify',
                          isLoading: controller.isLoading.value,
                          isEnabled: isOtpComplete,
                          backgroundColor: isOtpComplete
                              ? AppColors.primarycolor
                              : AppColors.buttoncolor,
                          textColor: isOtpComplete
                              ? AppColors.primarytext
                              : AppColors.secondarytext,
                          onTap: () async {
                            if (!isOtpComplete) return;

                            final result = await controller.verifyOtp(
                              otpController.text.trim(),
                              isForgotPassword:
                                  widget.source == Otpsource.forgetpassword,
                              email: widget.email?.trim(),
                            );

                            if (result) {
                              if (widget.source == Otpsource.forgetpassword) {
                                Get.off(() => const NewPasswordView());
                              } else {
                                Get.off(
                                  () => const AcoountCogratulationsPage(),
                                );
                              }
                            }
                          },
                        ),
                      );
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
