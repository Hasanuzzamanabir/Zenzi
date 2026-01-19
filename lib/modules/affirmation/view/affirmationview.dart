// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';

class AffirmationView extends StatelessWidget {
  const AffirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.componentnormal,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 80.w),
                  Text('Affirmation', style: AppTextStyle.h7),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                '1 of 90',
                style: AppTextStyle.button.copyWith(
                  color: AppColors.secondarycolor,
                ),
              ),
              SizedBox(height: 24.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.chevron_left),
                    ),
                  ),

                  /// RIGHT ARROW
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.chevron_right),
                    ),
                  ),
                  Image.asset(
                    AppAssets.affirmationcard,
                    width: 350.w,
                    height: 400.h,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(
                      'I am rooted in the strength of \nmy ancestors. Their \nresilience flows through me.',
                      style: AppTextStyle.h7.copyWith(
                        color: AppColors.primarytext,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.chevron_left),
                    ),
                  ),

                  /// RIGHT ARROW
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.chevron_right),
                    ),
                  ),

                  SizedBox(height: 20),
                  Positioned(
                    bottom: 90,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      child: Text(
                        "Strength",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: Color(0xFFFFFFFF).withOpacity(0.20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AppColors.primarycolor,
                        border: Border.all(
                          color: AppColors.secondarycolor,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Save',
                            style: AppTextStyle.button.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AppColors.primarycolor,
                        border: Border.all(
                          color: AppColors.secondarycolor,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Share',
                            style: AppTextStyle.button.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.primarycolor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Column(
                  children: [
                    Text(
                      '"A person is a person because of other \npeople."',
                      style: AppTextStyle.h6.copyWith(
                        color: Color(0xFF2F2F2F),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(),
                      child: Text(
                        '- Ubuntu Philosophy',
                        style: AppTextStyle.h6.copyWith(
                          color: Color(0xFF2F2F2F),
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
