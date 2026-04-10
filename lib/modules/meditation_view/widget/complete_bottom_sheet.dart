// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zenzi/core/theme/app_colors.dart';

// class CompletionBottomSheet {
//   const CompletionBottomSheet._();

//   static Future<T?> show<T>({
//     required BuildContext context,
//     required String title,
//     required String description,
//     required String primaryLabel,
//     required String secondaryLabel,
//     required VoidCallback onPrimaryPressed,
//     VoidCallback? onSecondaryPressed,
//   }) {
//     return showModalBottomSheet<T>(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (BuildContext sheetContext) {
//         return _CompletionBottomSheetContent(
//           title: title,
//           description: description,
//           primaryLabel: primaryLabel,
//           secondaryLabel: secondaryLabel,
//           onPrimaryPressed: onPrimaryPressed,
//           onSecondaryPressed: onSecondaryPressed,
//           sheetContext: sheetContext,
//         );
//       },
//     );
//   }
// }

// class _CompletionBottomSheetContent extends StatelessWidget {
//   const _CompletionBottomSheetContent({
//     required this.title,
//     required this.description,
//     required this.primaryLabel,
//     required this.secondaryLabel,
//     required this.onPrimaryPressed,
//     required this.sheetContext,
//     this.onSecondaryPressed,
//   });

//   final String title;
//   final String description;
//   final String primaryLabel;
//   final String secondaryLabel;
//   final VoidCallback onPrimaryPressed;
//   final VoidCallback? onSecondaryPressed;
//   final BuildContext sheetContext;

//   void _closeSheet() {
//     Navigator.of(sheetContext).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 28.h),
//       decoration: BoxDecoration(
//         color: AppColors.navbackground,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 48.w,
//               height: 5.h,
//               decoration: BoxDecoration(
//                 color: Colors.white24,
//                 borderRadius: BorderRadius.circular(999.r),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             description,
//             style: TextStyle(
//               color: AppColors.secondarycolor,
//               fontSize: 14.sp,
//             ),
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {
//                     _closeSheet();
//                     onPrimaryPressed();
//                   },
//                   child: Text(primaryLabel),
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _closeSheet();
//                     onSecondaryPressed?.call();
//                   },
//                   child: Text(secondaryLabel),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/theme/app_colors.dart';
class CompletionBottomSheetContent extends StatelessWidget {
  const CompletionBottomSheetContent({
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimaryPressed,
    required this.sheetContext,
    this.onSecondaryPressed,
  });

  final String title;
  final String description;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final BuildContext sheetContext;

  void _closeSheet() {
    Navigator.of(sheetContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 28.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC8893C), Color(0xFF8B5A2B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Drag handle
          Container(
            width: 48.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),

          SizedBox(height: 16.h),

          /// Close button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: _closeSheet,
              child: const Icon(Icons.close, color: Colors.black),
            ),
          ),

          SizedBox(height: 8.h),

          /// Title
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 6.h),

          /// Description
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          /// Image (replace with your asset)
          Image.asset(
            AppAssets.simplification,
            height: 120.h,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 20.h),

          /// Points
          Text(
            "You got 50 Points",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 12.h),

          /// Progress text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Left to reach level 2",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                "132/250",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          /// Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: 132 / 250,
              minHeight: 6.h,
              backgroundColor: Colors.black,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC68A47)),
            ),
          ),

          SizedBox(height: 24.h),

          /// Next Button (Primary style)
          SizedBox(
           // width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _closeSheet();
                onSecondaryPressed?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.congratsscrennbuttonclr,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    secondaryLabel,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(width: 8.w),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),

          SizedBox(height: 10.h),

          /// Secondary (Replay / Close)
          GestureDetector(
            onTap: () {
              _closeSheet();
              onPrimaryPressed();
            },
            child: Text(
              primaryLabel,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}