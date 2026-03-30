import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/text_label.dart';
import 'package:zenzi/modules/auth/view/login/view/log_in_view.dart';
import 'package:zenzi/modules/auth/view/signup/controller/signup_controller.dart';
//import 'package:zenzi/modules/auth/view/view/view/acoount_cogratulations_Page.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late final SignupController _controller;

  @override
  initState() {
    super.initState();
    _controller = Get.put(SignupController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset('assets/image/auth/logIconThree.svg'),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset('assets/image/auth/logIconFour.svg'),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 20.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 60.h,
                ),
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
                    TextLabel(text: 'Name'),
                    SizedBox(height: 9.h),
                    AppTextField(
                      hintText: 'Enter your name',
                      controller: _nameController,
                    ),
                    SizedBox(height: 12.h),
                    TextLabel(text: 'Email'),
                    SizedBox(height: 9.h),
                    AppTextField(
                      hintText: 'Enter your email',
                      controller: _emailController,
                    ),
                    SizedBox(height: 12.h),
                    TextLabel(text: 'Password'),
                    SizedBox(height: 9.h),
                    Obx(
                      () => AppTextField(
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        isPassword: _controller.isPasswordObscured.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controller.togglePasswordVisibility();
                          },
                          icon: Icon(
                            _controller.isPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          color: AppColors.textfieldiconcolor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextLabel(text: 'Confirm Password'),
                    SizedBox(height: 9.h),
                    Obx(
                      () => AppTextField(
                        hintText: 'Enter your confirm password',
                        controller: _confirmPasswordController,
                        isPassword: _controller.isConfirmPasswordObscured.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controller.toggleConfirmPasswordVisibility();
                          },
                          icon: Icon(
                            _controller.isConfirmPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          color: AppColors.textfieldiconcolor,
                        ),
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
                        //Get.to(const OtpVerification(isSigning: true));
                        final name = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        final confirmPassword = _confirmPasswordController.text
                            .trim();

                        print('Name: $name');
                        print('Email: $email');
                        print('Password: $password');
                        print('Confirm Password: $confirmPassword');
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
