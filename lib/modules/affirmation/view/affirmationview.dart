import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/affirmation/controller/affirmation_controller.dart';
import 'package:zenzi/modules/affirmation/model/affirmation_model.dart';

class AffirmationView extends StatelessWidget {
  const AffirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AffirmationController());

    final demoItem = AffirmationModel(
      id: -1,
      text: "Loading peaceful thoughts...",
      authorOrSource: "Connecting to server",
      isFavorited: false,
    );

    return ThemedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(() {
            final bool isSkeleton =
                controller.isLoading.value ||
                controller.affirmationList.isEmpty;

            final currentItem = isSkeleton
                ? demoItem
                : controller.affirmationList[controller.currentIndex.value];

            return Column(
              children: [
                SizedBox(height: 16.h),

                if (controller.hasError.value)
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, color: Colors.red, size: 16.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "No internet connection. Showing offline mode.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.whitelite,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    Text('Affirmation', style: AppTextStyle.h9),
                  ],
                ),

                SizedBox(height: 16.h),

                Text(
                  isSkeleton
                      ? '0 of 0'
                      : '${controller.currentIndex.value + 1} of ${controller.totalCount.value}',
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.secondarycolor,
                  ),
                ),

                SizedBox(height: 24.h),

                Opacity(
                  opacity: isSkeleton ? 0.6 : 1.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppAssets.affirmationcard,
                        width: 350.w,
                        height: 400.h,
                        fit: BoxFit.contain,
                      ),

                      Positioned(
                        top: 22.h,
                        right: 14.w,
                        child: Obx(
                          () => IconButton(
                            onPressed: isSkeleton
                                ? null
                                : () {
                                    if (controller.isSpeaking.value) {
                                      controller.stopSpeaking();
                                    } else {
                                      controller.speakText(
                                        currentItem.text ?? "",
                                      );
                                    }
                                  },
                            icon: Icon(
                              controller.isSpeaking.value
                                  ? Icons.volume_off_outlined
                                  : Icons.volume_up_outlined,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52.w),
                        child: Container(
                          height: 200.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 20.h,
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              currentItem.text ?? "No Text Available",
                              style: AppTextStyle.h7.copyWith(
                                color: AppColors.primarytext,
                                fontSize: 17.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 8.w,
                        child: IconButton(
                          icon: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.chevron_left,
                              color:
                                  isSkeleton ||
                                      controller.currentIndex.value == 0
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          onPressed: isSkeleton
                              ? null
                              : controller.previousAffirmation,
                        ),
                      ),

                      Positioned(
                        right: 8.w,
                        child: IconButton(
                          icon: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: controller.isLoadMore.value
                                ? SizedBox(
                                    width: 18.w,
                                    height: 18.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    Icons.chevron_right,
                                    color: isSkeleton
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                          ),
                          onPressed: isSkeleton
                              ? null
                              : () => controller.nextAffirmation(),
                        ),
                      ),

                      Positioned(
                        bottom: 90.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          child: Text(
                            currentItem.categoryName,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (controller.hasError.value && !controller.isLoading.value)
                  TextButton.icon(
                    onPressed: controller.refreshAffirmations,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry Connection"),
                  ),

                SizedBox(height: 24.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildBtn(
                        onTap: isSkeleton
                            ? () {}
                            : () => controller.toggleFavorite(
                                currentItem.id,
                                controller.currentIndex.value,
                              ),
                        icon: currentItem.isFavorited == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: 'Save',
                        iconColor: currentItem.isFavorited == true
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildBtn(
                        onTap: () {},
                        icon: Icons.share_outlined,
                        label: 'Share',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: AppColors.primarycolor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    '- ${currentItem.authorOrSource ?? "Unknown"}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBtn({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    Color iconColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.primarycolor,
          border: Border.all(color: AppColors.secondarycolor),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20.sp),
            SizedBox(width: 8.w),
            Text(label),
          ],
        ),
      ),
    );
  }
}
