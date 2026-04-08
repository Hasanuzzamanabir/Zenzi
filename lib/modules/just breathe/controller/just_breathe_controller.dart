import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/token/token_storage.dart';
import 'package:zenzi/modules/auth/view/login/view/log_in_view.dart';
import 'package:zenzi/modules/bottom_navigation_bar/view/custom_buttom_navigation_bar.dart';

class JustBreatheController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _animationController;

  AnimationController get animationController => _animationController;

  @override
  void onInit() {
    super.onInit();
    // Continuous smooth breathing: 0 -> 1 -> 0
    // Duration: 4 seconds one way (8 seconds full cycle) for a calm pace
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animationController.repeat(reverse: true);
  }

  Future<void> checkLoginStatus() async {
    final accessToken = await TokenStorage.getAccessToken();
    final refreshToken = await TokenStorage.getRefreshToken();

    if (accessToken != null &&
        accessToken.isNotEmpty &&
        refreshToken != null &&
        refreshToken.isNotEmpty) {
      // User is logged in, navigate to home
      Get.offAll(() => CustomButtomNavigationBar());
    } else {
      // User is not logged in, navigate to login
      Get.offAll(() => const LogInView());
    }
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}
