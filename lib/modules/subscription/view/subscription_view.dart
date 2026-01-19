import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/app_button.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/subscription/widgets/subscription_container.dart';
import 'package:zenzi/routes/app_routes.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
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
                SizedBox(height: 30.h),

                // Pricing Cards
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// MONTHLY PLAN
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(32.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.6),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '₦2,500',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'per month',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '',
                                style: TextStyle(
                                  color: Colors.transparent,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 14.w),

                      /// YEARLY PLAN (BEST VALUE)
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 20.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(32.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.6),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '₦20,000',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'per year',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Save ₦10,000',
                                      style: TextStyle(
                                        color: Color(0xFFFDE68A),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// BEST VALUE BADGE
                            Positioned(
                              top: -12.h,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFC107),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    'Best Value',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: ListView(
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

          // Why Go Premium Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD77348), Color(0xFFA15D39)],
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.secondarycolor, width: 1.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //SizedBox(width: 8.w),
                    Text(
                      '✨ Why Go Premium??',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _buildBulletPoint('Access all meditations without limits'),
                _buildBulletPoint('Download content for offline listening'),
                _buildBulletPoint('Exclusive sleep stories and music'),
                _buildBulletPoint('Learn from expert African teachers'),
                _buildBulletPoint('Unlock curated wellness journeys'),
                _buildBulletPoint('Cancel anytime, no commitment'),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Start Premium Button
          AppButton(
            title: 'Start Premium • ₦20,000',
            onTap: () => _showSubscriptionDialog(context),
            backgroundColor: AppColors.coreprimarydark,
            textColor: Colors.white,

            leading: Image.asset(AppAssets.crown),
            height: 50.h,
          ),
          SizedBox(height: 12.h),

          // Trial Info
          Text(
            '7-day free trial • Cancel anytime • Money-back \nguarantee',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.secondarycolor, fontSize: 16.sp),
          ),
          SizedBox(height: 24.h),

          // FAQ Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.congratsscrennbuttonclr.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.secondarycolor, width: 1.w),
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
                  style: TextStyle(color: AppColors.primarytext, fontSize: 16),
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
                  style: TextStyle(color: AppColors.primarytext, fontSize: 16),
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
                  style: TextStyle(color: AppColors.primarytext, fontSize: 16),
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
    );
  }

  void _showSubscriptionDialog(BuildContext context) {
    String selectedPaymentMethod = 'card'; // 'card' or 'bank'

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.skysunrise,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Complete Payment',
                          style: AppTextStyle.h8.copyWith(
                            color: AppColors.secondarycolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.close,
                            color: AppColors.secondarycolor,
                            size: 24.sp,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Order Summary Section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundhorizon,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order Summary', style: AppTextStyle.h7),

                          SizedBox(height: 12.h),

                          // Premium Item
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Zenzi Premium (Annual)',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                '₦20,000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),

                          // Savings
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Savings',
                                style: TextStyle(
                                  color: AppColors.backgroundbasecolor,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Save ₦10,000',
                                style: TextStyle(
                                  color: AppColors.backgroundbasecolor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          // Divider
                          Container(height: 1, color: Color(0xFFE5E7EB)),
                          SizedBox(height: 12.h),

                          // Total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₦20,000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Payment Method Section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundhorizon,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Color(0xFFE5E7EB),
                          width: 1.w,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 8.w),
                              Text(
                                '💳 Payment Method',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),

                          Text(
                            'Secure payment powered by Paystack',
                            style: TextStyle(
                              color: AppColors.secondarycolor,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Card Payment Option
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPaymentMethod = 'card';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: selectedPaymentMethod == 'card'
                                    ? const Color(0xFF4A2C1A)
                                    : const Color(0xFF5C3D2E).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Color(0xFFE5E7EB),
                                  width: 1.w,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: AppColors.backgroundcolor,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Icon(
                                      Icons.credit_card,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Card Payment',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          // Bank Transfer Option
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPaymentMethod = 'bank';
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: selectedPaymentMethod == 'bank'
                                    ? const Color(0xFF4A2C1A)
                                    : const Color(0xFF5C3D2E).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Color(0xFFE5E7EB),
                                  width: 1.w,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: AppColors.backgroundcolor,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Icon(
                                      Icons.account_balance,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Bank Transfer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Pay Button
                    AppButton(
                      title: 'Pay ₦20,000',
                      onTap: () {
                        // Add your payment logic here
                        Get.toNamed(AppRoute.getPremiumSubscriptionView());
                      },
                      backgroundColor: const Color(0xFF3D2817),
                      textColor: Colors.white,
                      height: 50.h,
                    ),
                    SizedBox(height: 12.h),

                    // Footer Text
                    Center(
                      child: Text(
                        'Secure payment • Cancel anytime • 7-day\nmoney back guarantee',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.secondarycolor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
