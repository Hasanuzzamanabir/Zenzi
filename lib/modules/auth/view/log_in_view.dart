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
import 'package:zenzi/modules/auth/view/forgot_password_view.dart';
import 'package:zenzi/modules/auth/view/signup_view.dart';

import '../../bottom_navigation_bar/view/custom_buttom_navigation_bar.dart'
    show CustomButtomNavigationBar;
//import 'package:zenzi/modules/auth/view/view/view/acoount_cogratulations_Page.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.login),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: Image.asset(
                              AppAssets.mainLogo,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Log In',
                            style: AppTextStyle.h1.copyWith(
                              color: AppColors.primarytext,
                            ),
                          ),
                          SizedBox(height: 22.h),
                          Text(
                            'Fill your information below or register with \nyour Google account',
                            style: AppTextStyle.h5,
                            textAlign: TextAlign.center,
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
                            isPassword: true,
                            suffixIcon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: AppColors.textfieldiconcolor,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.to(ForgotPasswordView());
                              },
                              child: Text(
                                'Forgot password?',
                                style: AppTextStyle.h5.copyWith(
                                  color: AppColors.secondarycolor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          AppButton(
                            title: 'Log In',
                            onTap: () {
                              Get.to((CustomButtomNavigationBar()));
                            },
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.primarycolor,
                                  thickness: 1.5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Text(
                                  'OR Sign up with',
                                  style: AppTextStyle.h6,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.primarycolor,
                                  thickness: 1.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Image.asset(
                            AppAssets.google,
                            width: 48.w,
                            height: 48.h,
                          ),
                          SizedBox(height: 20.h),
                          RichText(
                            text: TextSpan(
                              text: "Don’t have account?",
                              style: AppTextStyle.h5.copyWith(
                                color: AppColors.primarytext,
                              ),
                              children: [
                                TextSpan(
                                  text: '   Create account',
                                  style: AppTextStyle.h5.copyWith(
                                    color: AppColors.primarycolor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(SignupView());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
