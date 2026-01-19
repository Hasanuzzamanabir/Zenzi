import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/modules/subscription/widgets/subscription_container.dart';

class PremiumSubscriptionView extends StatelessWidget {
  const PremiumSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarydarker,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(340.h),
        child: AppBar(
          backgroundColor: const Color(0xFFCC8855),
          elevation: 0,
          automaticallyImplyLeading: false,

          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 20.h),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.subscriptioncolor1,
                  AppColors.subscriptioncolor2,
                  AppColors.subscriptioncolor3,
                ],
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: SafeArea(
                    top: false,
                    child: Stack(
                      children: [
                        /// BACK ARROW — TOP LEFT
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            onPressed: () => Get.back(),
                            padding: EdgeInsets.zero,
                          ),
                        ),

                        /// CROWN — TOP CENTER (NOT vertical center)
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AppAssets.crown,
                              width: 40.w,
                              height: 40.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                // Title
                Text(
                  'Zenzi Premium',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),

                // Subtitle
                Text(
                  'Unlock your full wellness potential',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 50.h),

                // Pricing Cards
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFF05D48), width: 1.w),
                    ),
                    child: Center(
                      child: Text(
                        'Your Subscription Ends in 15 Days',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(6.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.congratsscrennbuttonclr.withOpacity(0.8),
                //borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Renewal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Enable auto renewal for save time',
                        style: TextStyle(
                          color: AppColors.secondarycolor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFFC87A3F),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                // What's Included Section Header
                Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What's Included",
                      style: AppTextStyle.h7.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Feature Cards
                FeatureAccessCard(
                  title: 'Unlimited Meditation',
                  subtitle: 'Access over 1000+ guided meditations',
                  freeDescription: 'Not available',
                  premiumDescription: 'Available',
                  onTap: () {},
                  iconAsset: AppAssets.saved3,
                ),
                SizedBox(height: 12.h),

                FeatureAccessCard(
                  iconAsset: AppAssets.saved2,
                  title: 'Premium Music',
                  subtitle: 'Exclusive focus & sleep sounds',
                  freeDescription: 'Not available',
                  premiumDescription: 'Available',
                  onTap: () {},
                ),
                SizedBox(height: 12.h),

                FeatureAccessCard(
                  iconAsset: AppAssets.notification4,
                  title: 'Sleep Stories',
                  subtitle: 'Bedtime tales for deep rest',
                  freeDescription: 'Available',
                  premiumDescription: 'Available',
                  onTap: () {},
                ),
                SizedBox(height: 12.h),

                FeatureAccessCard(
                  iconAsset: AppAssets.down,
                  title: 'Offline Access',
                  subtitle: 'Download for offline use',
                  freeDescription: 'Not available',
                  premiumDescription: 'Available',
                  onTap: () {},
                ),
                SizedBox(height: 30.h),

                // Start Premium Button
                AppButton(
                  title: 'Cancel Subscription',

                  backgroundColor: Color(0xFFFB3748),
                  textColor: Colors.white,

                  //leading: Image.asset(AppAssets.crown),
                  height: 50.h,
                  onTap: () {},
                ),
                SizedBox(height: 12.h),

                // Trial Info
                Text(
                  '7-day free trial • Cancel anytime • Money-back \nguarantee',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondarycolor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 24.h),

                // FAQ Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.congratsscrennbuttonclr.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.secondarycolor,
                      width: 1.w,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Frequently Asked Questions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildFAQ(
                        'Can I cancel anytime?',
                        style: TextStyle(
                          color: AppColors.primarytext,
                          fontSize: 16,
                        ),
                      ),
                      _buildFAQ(
                        '— Yes, cancel anytime from your profile settings.',
                        style: TextStyle(
                          color: AppColors.secondarycolor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildFAQ(
                        'What payment methods do you accept?',
                        style: TextStyle(
                          color: AppColors.primarytext,
                          fontSize: 16,
                        ),
                      ),
                      _buildFAQ(
                        '— We accept cards and bank transfers via Paystack.',
                        style: TextStyle(
                          color: AppColors.secondarycolor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildFAQ(
                        'Is there a free trial?',
                        style: TextStyle(
                          color: AppColors.primarytext,
                          fontSize: 16,
                        ),
                      ),
                      _buildFAQ(
                        '— Yes! Try Premium free for 7 days.',
                        style: TextStyle(
                          color: AppColors.secondarycolor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✓ ',
            style: TextStyle(
              color: AppColors.componentnormal,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ(String text, {required TextStyle style}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(text, style: style),
    );
  }
}
