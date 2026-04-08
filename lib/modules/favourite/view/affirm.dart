// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zenzi/core/theme/app_colors.dart';
// import 'package:zenzi/modules/favourite/widgets/affiirm_card.dart';
// import 'package:zenzi/modules/favourite/widgets/custom_share_bottom_sheet.dart';

// class Affirm extends StatelessWidget {
//   const Affirm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 20.h),
//         Column(
//           children: [
//             AffirmCard(
//               text:
//                   "I am rooted in the strength of my ancestors. Their resilience flows through me.",
//               backgroundColor: AppColors.componentnormal,
//               onLongPress: () => CustomShareBottomSheet.show(
//                 context,
//                 "I am rooted in the strength of my ancestors. Their resilience flows through me.",
//               ),
//             ),
//             SizedBox(height: 16.h),
//             AffirmCard(
//               text:
//                   "With every breath, I embrace my heritage and honor the journey of those who came before me.",
//               backgroundColor: AppColors.coreprimarydark,
//               onLongPress: () => CustomShareBottomSheet.show(
//                 context,
//                 "With every breath, I embrace my heritage and honor the journey of those who came before me.",
//               ),
//             ),
//             SizedBox(height: 16.h),
//             AffirmCard(
//               text:
//                   "I am rooted in the strength of my ancestors. Their resilience flows through me.",
//               backgroundColor: AppColors.componentnormal,
//               onLongPress: () => CustomShareBottomSheet.show(
//                 context,
//                 "I am rooted in the strength of my ancestors. Their resilience flows through me.",
//               ),
//             ),
//             SizedBox(height: 16.h),
//             AffirmCard(
//               text:
//                   "I am rooted in the strength of my ancestors. Their resilience flows through me.",
//               backgroundColor: AppColors.coreprimarydark,
//               onLongPress: () => CustomShareBottomSheet.show(
//                 context,
//                 "I am rooted in the strength of my ancestors. Their resilience flows through me.",
//               ),
//             ),
//             // MusicCardWidget(isFav: true),
//             SizedBox(height: 30.h),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/favourite/controller/favourite_affirm_controller.dart';
import 'package:zenzi/modules/favourite/model/favourite_affirmation_model.dart'; 
import 'package:zenzi/modules/favourite/widgets/affiirm_card.dart';
import 'package:zenzi/modules/favourite/widgets/custom_share_bottom_sheet.dart';

class Affirm extends StatelessWidget {
  const Affirm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteAffirmController());

    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.affirmationList.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: const Center(child: Text("No affirmations found!")),
        );
      }

      return Column(
        children: [
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.affirmationList.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final AffirmationModel item = controller.affirmationList[index];

              return AffirmCard(
                text: item.text!,
                backgroundColor: index % 2 == 0 
                    ? AppColors.componentnormal 
                    : AppColors.coreprimarydark,
                onLongPress: () => CustomShareBottomSheet.show(
                  context,
                  item.shareText ?? item.text,
                ),
              );
            },
          ),
          SizedBox(height: 30.h),
        ],
      );
    });
  }
}