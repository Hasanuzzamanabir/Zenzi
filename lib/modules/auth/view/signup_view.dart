import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/modules/auth/view/acoount_cogratulations_Page.dart';
import 'package:zenzi/modules/auth/view/log_in_view.dart';
import 'package:zenzi/modules/auth/view/otp_verification.dart';
//import 'package:zenzi/modules/auth/view/view/view/acoount_cogratulations_Page.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: AssetImage('assets/image/auth/createaccount.png'),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: AppTextStyle.h1.copyWith(
                        color: AppColors.primarytext,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Text(
                      'Fill Your Information below or register with \n your google account',
                      style: AppTextStyle.h5,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 41.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        style: AppTextStyle.h5.copyWith(
                          color: AppColors.primarytext,
                        ),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    AppTextField(
                      hintText: 'Enter your name',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 12.h),
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
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: AppTextStyle.h5.copyWith(
                          color: AppColors.primarytext,
                        ),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    AppTextField(
                      hintText: 'Enter your password',
                      controller: TextEditingController(),
                      suffixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.textfieldiconcolor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Confirm Password',
                        style: AppTextStyle.h5.copyWith(
                          color: AppColors.primarytext,
                        ),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    AppTextField(
                      hintText: 'Enter your confirm password',
                      controller: TextEditingController(),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        color: AppColors.textfieldiconcolor,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.checkbox,
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'Agree with ',
                              style: AppTextStyle.h6,
                              children: [
                                TextSpan(
                                  text: 'Terms Conditions & Privacy Policy',
                                  style: AppTextStyle.h6.copyWith(
                                    color: AppColors.primarycolor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      title: 'Sign Up',
                      onTap: () {
                        Get.to(const OtpVerification(isSigning: true));
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.congratsscrennbuttonclr,
                            thickness: 1.5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'OR Sign up with',
                            style: AppTextStyle.h6.copyWith(
                              color: AppColors.primarycolor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.congratsscrennbuttonclr,
                            thickness: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Image.asset(AppAssets.google, width: 48.w, height: 48.h),
                    SizedBox(height: 20.h),
                    RichText(
                      text: TextSpan(
                        text: "Already have account ? ",
                        style: AppTextStyle.h5.copyWith(
                          color: AppColors.primarycolor,
                        ),
                        children: [
                          TextSpan(
                            text: ' Log In',
                            style: AppTextStyle.h5.copyWith(
                              color: AppColors.primarytext,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(LogInView());
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
