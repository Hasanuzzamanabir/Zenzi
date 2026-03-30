import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/app_textfield.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondarycolor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Edit Profile",
          style: AppTextStyle.h2.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                //SizedBox(height: 24.h),

                // Title
                Text(
                  'Personal Information',
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

                // Profile Image with Edit Icon
                Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF1976D2),
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AppAssets.editprofile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 110,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Color(0xFF1976D2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Full Name Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Full Name',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Full Name Field
                AppTextField(
                  hintText: 'e.g. John Doe',
                  controller: fullNameController,
                ),

                SizedBox(height: 20.h),

                // Email Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Email Field
                AppTextField(
                  hintText: 'e.g. John@gmail.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 20.h),

                // Phone Number Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'phone Number',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Phone Number Field
                AppTextField(
                  hintText: 'e.g. +67647236425',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Date of Birth ',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Date of Birth Field
                AppTextField(
                  hintText: '13/09/1999',

                  suffixIcon: Icon(
                    Icons.calendar_today_sharp,
                    color: AppColors.darktext,
                  ),
                ),

                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: AppTextStyle.h5.copyWith(
                      color: AppColors.primarytext,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Full Name Field
                AppTextField(
                  hintText: 'Male',

                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.darktext,
                  ),
                ),

                //SizedBox(height: 20.h),
                SizedBox(height: 40.h),

                // Save Button
                AppButton(
                  title: 'Edit',
                  onTap: () {
                    // Handle save profile
                  },
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
