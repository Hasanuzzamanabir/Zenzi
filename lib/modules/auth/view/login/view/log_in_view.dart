import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/text_label.dart';
import 'package:zenzi/modules/auth/view/forgot_password/view/forgot_password_view.dart';
import 'package:zenzi/modules/auth/view/login/controller/login_controller.dart';
import 'package:zenzi/modules/auth/view/signup/view/signup_view.dart';
import 'package:zenzi/modules/bottom_navigation_bar/controller/custom_bottom_navigation_bar_controller.dart';
import 'package:zenzi/routes/app_routes.dart';

// import '../../../../bottom_navigation_bar/view/custom_buttom_navigation_bar.dart'
//     show CustomButtomNavigationBar;

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(LoginController());

    _controller.resetPasswordVisibility();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset('assets/image/auth/logIconOne.svg'),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset('assets/image/auth/logIconTwo.svg'),
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
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 20.h,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 60.h,
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
                              isPassword: _controller.isObscure.value,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _controller.togglePasswordVisibility();
                                },
                                icon: Icon(
                                  _controller.isObscure.value
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.textfieldiconcolor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => const ForgotPasswordView());
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
                          Obx(
                            () => AppButton(
                              title: 'Log In',
                              isLoading: _controller.isLoading.value,
                              onTap: () async {
                                final email = _emailController.text.trim();
                                final password = _passwordController.text
                                    .trim();

                                final result = await _controller.login(
                                  email,
                                  password,
                                );
                                if (result) {
                                  final navController =
                                      Get.isRegistered<
                                        CustomBottomNavigationBarController
                                      >()
                                      ? Get.find<
                                          CustomBottomNavigationBarController
                                        >()
                                      : Get.put(
                                          CustomBottomNavigationBarController(),
                                        );
                                  navController.changeTabIndex(0);
                                  Get.offAllNamed(
                                    AppRoute.custombottomNavigationBar,
                                  );
                                }
                              },
                            ),
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
                                  text: '  Create new account',
                                  style: AppTextStyle.h5.copyWith(
                                    color: AppColors.primarycolor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => const SignupView());
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
