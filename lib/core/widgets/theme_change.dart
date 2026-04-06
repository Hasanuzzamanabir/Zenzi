import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/preference/controller/time_slot_controller.dart';

Color get brownColor {
  final controller = Get.isRegistered<TimeSlotController>()
      ? Get.find<TimeSlotController>()
      : null;

  if (controller == null) {
    // Fallback: use device time if the controller isn't registered yet
    final isNight = DateTime.now().hour >= 18 || DateTime.now().hour < 6;
    return isNight ? const Color(0xFF1D1249) : AppColors.backgroundcolor;
  }

  return controller.selectedIndex.value == 0
      ? AppColors
            .backgroundcolor // Morning
      : const Color(0xFF1D1249); // Evening
}
