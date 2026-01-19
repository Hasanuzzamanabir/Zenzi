import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}
