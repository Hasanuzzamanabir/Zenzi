// // ignore_for_file: sort_child_properties_last, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:zenzi/core/theme/app_colors.dart';
// import 'package:zenzi/core/theme/app_text_style.dart';
// import 'package:zenzi/core/values/app_assets.dart';
// import 'package:zenzi/core/widgets/themed_scaffold.dart';
// import 'package:zenzi/modules/affirmation/controller/affirmation_controller.dart';

// class AffirmationView extends StatelessWidget {
//   const AffirmationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put( AffirmationController());
//     return ThemedScaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Obx(() =>
//              Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 16.h),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_back,
//                         color: AppColors.componentnormal,
//                       ),
//                       onPressed: () {
//                         Get.back();
//                       },
//                     ),
//                     SizedBox(width: 80.w),
//                     Text('Affirmation', style: AppTextStyle.h9),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   '1 of 90',
//                   style: AppTextStyle.button.copyWith(
//                     color: AppColors.secondarycolor,
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Positioned(
//                       left: 10,
//                       top: 0,
//                       bottom: 0,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.chevron_left),
//                       ),
//                     ),
            
//                     /// RIGHT ARROW
//                     Positioned(
//                       right: 10,
//                       top: 0,
//                       bottom: 0,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.chevron_right),
//                       ),
//                     ),
//                     Image.asset(
//                       AppAssets.affirmationcard,
//                       width: 350.w,
//                       height: 400.h,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(16.w),
//                       child: Text(
//                         'I am rooted in the strength of \nmy ancestors. Their \nresilience flows through me.',
//                         style: AppTextStyle.h7.copyWith(
//                           color: AppColors.primarytext,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Positioned(
//                       left: 10,
//                       top: 0,
//                       bottom: 0,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.chevron_left),
//                       ),
//                     ),
            
//                     /// RIGHT ARROW
//                     Positioned(
//                       right: 10,
//                       top: 0,
//                       bottom: 0,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.chevron_right),
//                       ),
//                     ),
            
//                     SizedBox(height: 20),
//                     Positioned(
//                       bottom: 90,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 12.w,
//                           vertical: 6.h,
//                         ),
//                         child: Text(
//                           "Strength",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25.r),
//                           color: Color(0xFFFFFFFF).withOpacity(0.20),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 14.h),
//                         decoration: BoxDecoration(
//                           color: AppColors.primarycolor,
//                           border: Border.all(
//                             color: AppColors.secondarycolor,
//                             width: 1.w,
//                           ),
//                           borderRadius: BorderRadius.circular(30.r),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.favorite_border,
//                               color: Colors.black,
//                               size: 20.sp,
//                             ),
//                             SizedBox(width: 8.w),
//                             Text(
//                               'Save',
//                               style: AppTextStyle.button.copyWith(
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16.w),
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 14.h),
//                         decoration: BoxDecoration(
//                           color: AppColors.primarycolor,
//                           border: Border.all(
//                             color: AppColors.secondarycolor,
//                             width: 1.w,
//                           ),
//                           borderRadius: BorderRadius.circular(30.r),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.share_outlined,
//                               color: Colors.black,
//                               size: 20.sp,
//                             ),
//                             SizedBox(width: 8.w),
//                             Text(
//                               'Share',
//                               style: AppTextStyle.button.copyWith(
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24.h),
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
//                   decoration: BoxDecoration(
//                     color: AppColors.primarycolor,
//                     borderRadius: BorderRadius.circular(30.r),
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         '"A person is a person because of other \npeople."',
//                         style: AppTextStyle.h6.copyWith(
//                           color: Color(0xFF2F2F2F),
//                           fontStyle: FontStyle.italic,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 12.h),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 16.w,
//                           vertical: 6.h,
//                         ),
//                         decoration: BoxDecoration(),
//                         child: Text(
//                           '- Ubuntu Philosophy',
//                           style: AppTextStyle.h6.copyWith(
//                             color: Color(0xFF2F2F2F),
//                             fontSize: 16.sp,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: sort_child_properties_last, deprecated_member_use

// ignore_for_file: sort_child_properties_last, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/affirmation/controller/affirmation_controller.dart';

class AffirmationView extends StatelessWidget {
  const AffirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AffirmationController());

    return ThemedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.affirmationList.isEmpty) {
              return const Center(child: Text('No Affirmations Found!'));
            }

            final currentItem = controller.affirmationList[controller.currentIndex.value];

            return Column(
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
                    Text('Affirmation', style: AppTextStyle.h9),
                    SizedBox(width: 48.w),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  '${controller.currentIndex.value + 1} of ${controller.totalCount.value}',
                  style: AppTextStyle.button.copyWith(color: AppColors.secondarycolor),
                ),
                SizedBox(height: 24.h),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AppAssets.affirmationcard, width: 350.w, height: 400.h),
                    
                    // Main Text (Affirmation বাণী)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45.w),
                      child: Container(
                        height: 200.h,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Text(
                            currentItem.text ?? "No Text Available",
                            style: AppTextStyle.h7.copyWith(color: AppColors.primarytext, fontSize: 17.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 10,
                      child: IconButton(
                        icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.chevron_left, color: Colors.black)),
                        onPressed: () => controller.previousAffirmation(),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: IconButton(
                        icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.chevron_right, color: Colors.black)),
                        onPressed: () => controller.nextAffirmation(),
                      ),
                    ),

                    Positioned(
                      bottom: 90.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Text(currentItem.categoryName, style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildBtn(
                        onTap: () => controller.toggleFavorite(currentItem.id, controller.currentIndex.value),
                        icon: currentItem.isFavorited == true ? Icons.favorite : Icons.favorite_border,
                        label: 'Save',
                        iconColor: currentItem.isFavorited == true ? Colors.red : Colors.black,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(child: _buildBtn(onTap: () {
                      
                    }, icon: Icons.share_outlined, label: 'Share')),
                  ],
                ),
                SizedBox(height: 24.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(color: AppColors.primarycolor, borderRadius: BorderRadius.circular(30.r)),
                  child: Text('- ${currentItem.authorOrSource ?? "Unknown"}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBtn({required VoidCallback onTap, required IconData icon, required String label, Color iconColor = Colors.black}) {
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
          children: [Icon(icon, color: iconColor, size: 20.sp), SizedBox(width: 8.w), Text(label)],
        ),
      ),
    );
  }
}