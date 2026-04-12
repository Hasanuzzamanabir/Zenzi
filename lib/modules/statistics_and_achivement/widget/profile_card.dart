import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/theme/app_text_style.dart';
import 'package:zenzi/modules/setting/controller/edit_profile_controller.dart';

class ProfileCard extends StatelessWidget {
  final Color color;
  final String? name;
  final String? avatarUrl;
  final String? levelTitle;
  final int? points;

  const ProfileCard({
    super.key,
    required this.color,
    this.name,
    this.avatarUrl,
    this.levelTitle,
    this.points,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    String? resolveAvatarUrl(String? rawUrl) {
      if (rawUrl == null || rawUrl.trim().isEmpty) return null;

      final trimmed = rawUrl.trim();
      final uri = Uri.tryParse(trimmed);
      if (uri != null && uri.hasScheme) return trimmed;

      final normalizedPath = trimmed.startsWith('/') ? trimmed : '/$trimmed';
      return '${BaseUrl.baseUrl}$normalizedPath';
    }

    final fallbackProfile = controller.profile.value;
    final resolvedName = (name ?? fallbackProfile?.name ?? 'Steven Smith')
        .trim();
    final resolvedLevel = (levelTitle ?? 'Grounded').trim().isEmpty
        ? 'Grounded'
        : (levelTitle ?? 'Grounded').trim();
    final resolvedPoints = points ?? 598;
    final resolvedAvatar = resolveAvatarUrl(
      avatarUrl ?? fallbackProfile?.avatarUrl,
    );

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.backgroundbasecolor.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Profile Image
          CircleAvatar(
            radius: 32.r,
            backgroundImage: resolvedAvatar != null
                ? NetworkImage(resolvedAvatar)
                : const AssetImage('assets/image/home/profile.png')
                      as ImageProvider,
          ),

          SizedBox(width: 14.w),

          /// Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Good Morning',
                  style: AppTextStyle.h4.copyWith(
                    color: AppColors.primarytext,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  resolvedName.isEmpty ? 'Steven Smith' : resolvedName,
                  style: AppTextStyle.h2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'Level: $resolvedLevel',
                      style: AppTextStyle.bodyMediumBold.copyWith(
                        color: AppColors.secondarycolor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darktext,
                        borderRadius: BorderRadius.circular(16.r),
                        //
                      ),
                      child: Text(
                        '$resolvedPoints pts',
                        style: AppTextStyle.h3.copyWith(
                          color: AppColors.secondarycolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Points Badge (Far Right)
        ],
      ),
    );
  }
}
