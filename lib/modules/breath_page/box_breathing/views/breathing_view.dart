import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import '../controllers/breathing_controller.dart';
import '../painters/breathing_painter.dart';

class BoxBreathingView extends StatelessWidget {
  final int exerciseId;
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final int recommendedCycles;
  final int totalSession;

  const BoxBreathingView({
    super.key,
    required this.exerciseId,
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
    required this.recommendedCycles,
    required this.totalSession,
  });

  @override
  Widget build(BuildContext context) {
    final BoxBreathingController controller = Get.put(
      BoxBreathingController(
        exerciseId: exerciseId,
        inhaleSeconds: inhaleSeconds,
        holdSeconds: holdSeconds,
        exhaleSeconds: exhaleSeconds,
        totalCycles: recommendedCycles,
        totalSession: totalSession,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.boxbreathingcolor1,
                  AppColors.boxbreathingcolor2,
                ],
              ),
            ),
          ),

          // 2. Main Animation (Centered)
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                controller.mainController,
                controller.rotationAnimation,
              ]),
              builder: (context, child) {
                // Determine Visual Radius (0.0 to 1.0)
                double visualValue = 0.0;
                final phase = controller.phase;
                final rawValue = controller.mainController.value;

                if (phase == 1) {
                  // Inhale: 0 -> 1
                  visualValue = rawValue;
                } else if (phase == 2) {
                  // Hold: Static 1.0
                  visualValue = 1.0;
                } else if (phase == 3) {
                  // Exhale: 1 -> 0
                  visualValue = 1.0 - rawValue;
                } else {
                  // Completed or default
                  visualValue = 0.0;
                }

                return SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(
                    painter: BoxBreathingPainter(
                      animationValue: visualValue,
                      rotationValue: controller.rotationAnimation.value,
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Top Right Cycle Count (Static location)
          Positioned(
            top: 50,
            right: 20,
            child: Obx(
              () => Text(
                "${controller.cycle}/${controller.totalCycles} cycles",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          // 4. Large Timer at Top Center (Mocks show it above circle)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(() {
                if (controller.phase == 0) return const SizedBox.shrink();
                return Text(
                  "${controller.countdown}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                  ),
                );
              }),
            ),
          ),

          // 5. Bottom Section: Title, Subtitle, Dots, Hint
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Phase Title (Hold, etc)
                Obx(
                  () => Text(
                    controller.titleText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Box Breathing Subtitle
                Text(
                  "Box Breathing",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),

                // Cycle Dots
                Obx(() {
                  final currentCycle = controller.cycle; // Completed cycles
                  final total = controller.totalCycles;

                  // If we are in the middle of cycle 0 (first run), count is 0.
                  // Mocks show 5 dots.
                  // Ideally, if cycle 1 is *done*, dot 1 fills? Or if cycle 1 is *active*, dot 1 fills?
                  // User said "A dot becomes ACTIVE only after a complete cycle finishes".
                  // So 0 cycles done -> 0 dots active.

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(total, (index) {
                      // index 0..4
                      // if currentCycle=1 (1 done), index 0 is active.
                      final bool isActive = index < currentCycle;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: isActive ? 10 : 8,
                        height: isActive ? 10 : 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  );
                }),

                const SizedBox(height: 40),

                // Bottom Hint
                Obx(
                  () => Text(
                    controller.subtitleText,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back Button (Top Left) - Optional per mock
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
                // No-op for single screen demo, or Get.back() if nav existed
              },
            ),
          ),
        ],
      ),
    );
  }
}
