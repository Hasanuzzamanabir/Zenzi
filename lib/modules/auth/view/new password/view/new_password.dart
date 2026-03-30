import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';

import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/text_label.dart';
import 'package:zenzi/modules/auth/view/login/view/log_in_view.dart';
import 'package:zenzi/modules/auth/view/new%20password/controller/new_password_controller.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final NewPasswordController _controller;

  @override
  void initState() {
    _controller = NewPasswordController();
    super.initState();
  }

  @override
  dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondarycolor),
          onPressed: () => Get.back(),
        ),

        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 52.h),
                Text('New Password', style: AppTextStyle.h2),

                SizedBox(height: 10.h),
                TextLabel(text: 'Create New Password'),
                SizedBox(height: 9.h),
                Obx(
                  () => AppTextField(
                    hintText: 'Enter your email',
                    controller: _passwordController,
                    isPassword: _controller.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _controller.togglePasswordVisibility();
                      },
                      icon: Icon(
                        _controller.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      color: AppColors.textfieldiconcolor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextLabel(text: 'Re-Type Password'),
                SizedBox(height: 9.h),
                Obx(
                  () => AppTextField(
                    hintText: 'Enter your email',
                    controller: _confirmPasswordController,
                    isPassword: _controller.isConfirmPasswordVisible.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _controller.toggleConfirmPasswordVisibility();
                      },
                      icon: Icon(
                        _controller.isConfirmPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      color: AppColors.textfieldiconcolor,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                AppButton(
                  title: 'Save',
                  onTap: () {
                    Get.to(const LogInView());
                  },
                ),
              ],
            ),
          ),
        ),

        // Back arrow button
        // Positioned(
        //   left: 16,
        //   top: 0,
        //   child: IconButton(
        //     padding: EdgeInsets.zero,
        //     alignment: Alignment.centerLeft,
        //     icon: const Icon(Icons.arrow_back),
        //     color: AppColors.secondarycolor,
        //     onPressed: () => Get.back(),
        //   ),
        // ),
      ),
    );
  }
}
