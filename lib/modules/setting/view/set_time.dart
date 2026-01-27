import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';

class SetTimeView extends StatelessWidget {
  const SetTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.secondarycolor,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Set Time',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Set Meditation Time
              _buildTimeSection(
                image: AssetImage(AppAssets.stress),
                title: 'Set Meditation Time',
              ),
              SizedBox(height: 20.h),

              // Set Sleeping time
              _buildTimeSection(
                image: AssetImage(AppAssets.hotel),
                title: 'Set Sleeping time',
              ),
              SizedBox(height: 20.h),

              // Set breathing exercise time
              _buildTimeSection(
                image: AssetImage(AppAssets.pulmonology),
                title: 'Set breathing exercise time',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSection({
    required ImageProvider image,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image(image: image, color: Colors.white, width: 20.w, height: 20.h),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.skysunrise,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primarytext, width: 1),
          ),
          child: Row(
            children: [
              Text(
                'Start Time:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 12.w),
              // Hour
              _buildTimeBox('10'),
              SizedBox(width: 8.w),
              Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF983500),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              // Minute
              _buildTimeBox('00'),
              SizedBox(width: 12.w),
              // AM/PM
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.backgroundhorizon,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'AM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Spacer(),
              Icon(
                Icons.alarm,
                color: AppColors.backgroundhorizon,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundhorizon,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
