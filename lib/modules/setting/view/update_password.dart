import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/text_label.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/setting/controller/update_password_controller.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final UpdatePasswordController updatePasswordController = Get.put(
    UpdatePasswordController(),
  );

  @override
  void initState() {
    super.initState();
    updatePasswordController.resetVisibility();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Header Row
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.primarytext,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(width: 8.w),
                    Text('Update password', style: AppTextStyle.h2),
                  ],
                ),

                SizedBox(height: 24.h),

                // Title
                Text(
                  'Update Your Password',
                  style: AppTextStyle.h2.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  'Provide your basics information',
                  style: AppTextStyle.h5.copyWith(
                    color: AppColors.secondarycolor,
                    fontSize: 13.sp,
                  ),
                ),

                SizedBox(height: 32.h),

                // Current Password Label
                TextLabel(text: 'Current Password'),
                SizedBox(height: 8.h),

                // Current Password Field
                Obx(
                  () => AppTextField(
                    hintText: '************',
                    controller: currentPasswordController,
                    isPassword: updatePasswordController.currentPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        updatePasswordController.currentPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primarycolor,
                      ),
                      onPressed: () {
                        updatePasswordController.toggleCurrentPassword();
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // New Password Label
                TextLabel(text: 'New Password'),

                SizedBox(height: 8.h),

                // New Password Field
                Obx(
                  () => AppTextField(
                    hintText: '************',
                    controller: newPasswordController,
                    isPassword: updatePasswordController.newPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        updatePasswordController.newPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primarycolor,
                      ),
                      onPressed: () {
                        updatePasswordController.toggleNewPassword();
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Confirm New Password Label
                TextLabel(text: 'Confirm New Password'),

                SizedBox(height: 8.h),

                // Confirm New Password Field
                Obx(
                  () => AppTextField(
                    hintText: '************',
                    controller: confirmPasswordController,
                    isPassword: updatePasswordController.confirmPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        updatePasswordController.confirmPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primarycolor,
                      ),
                      onPressed: () {
                        updatePasswordController.toggleConfirmPassword();
                      },
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Save Button
                Obx(
                  () => AppButton(
                    title: 'Save',
                    isLoading: updatePasswordController.isLoading.value,
                    onTap: () async {
                      final result = await updatePasswordController
                          .updatePassword(
                            currentPasswordController.text,
                            newPasswordController.text,
                            confirmPasswordController.text,
                          );
                      if (result) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        currentPasswordController.clear();
                        newPasswordController.clear();
                        confirmPasswordController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
