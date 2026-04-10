import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/values/app_assets.dart';
import '../controllers/energizing_breathing_controller.dart';
import '../painters/Energizing_breathing_painter.dart';

class EnergizingBreathingView extends StatelessWidget {
  final int exerciseId;
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final int recommendedCycles;
  final int totalSession;

  const EnergizingBreathingView({
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
    final EnergizingBreathingController controller = Get.put(
      EnergizingBreathingController(
        exerciseId: exerciseId,
        inhaleSeconds: inhaleSeconds,
        holdSeconds: holdSeconds,
        exhaleSeconds: exhaleSeconds,
        totalCycles: recommendedCycles,
        totalSession: totalSession,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Obx(
                () => Text(
                  "${controller.cycle}/${controller.totalCycles} cycles",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Background Gradient (Deep Blue -> Light Blue)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A2980), // Deep Blue
                  Color(0xFF26D0CE), // Light Aqua Blue
                ],
              ),
            ),
          ),

          // 2. Main Animation (Centered)
          Center(
            child: AnimatedBuilder(
              animation: controller.mainController,
              builder: (context, child) {
                // Determine Visual Radius (0.0 to 1.0)
                double visualValue = 0.0;

                if (controller.phase == BreathPhase.inPhase) {
                  visualValue = controller.mainController.value;
                } else if (controller.phase == BreathPhase.outPhase) {
                  // Exhale: controller goes 1.0 -> 0.0 (reverse)
                  visualValue = controller.mainController.value;
                } else if (controller.phase == BreathPhase.hold) {
                  visualValue = 1.0;
                } else {
                  visualValue = 0.0;
                }

                return SizedBox(
                  width: 320,
                  height: 320,
                  child: CustomPaint(
                    painter: EnergizingBreathingPainter(
                      animationValue: visualValue,
                    ),
                    // Static Icon in center
                    child: Center(
                      child: Image.asset(
                        AppAssets.thunder,
                        width: 64.w,
                        height: 64.h,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Large Timer at Top Center
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(() {
                if (controller.phase == BreathPhase.reset) {
                  return const SizedBox.shrink();
                }
                return Text(
                  "${controller.countdown}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 56,
                    fontWeight: FontWeight.w300,
                  ),
                );
              }),
            ),
          ),

          // 4. Bottom Section
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Phase Title
                Obx(
                  () => Text(
                    controller.titleText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  "Box Breathing",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 30),

                // Cycle Dots (8 dots)
                Obx(() {
                  final currentCycle = controller.cycle;
                  final total = controller.totalCycles;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(total, (index) {
                      final bool isActive = index < currentCycle;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ), // Tighter spacing for 8 dots
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? Colors.white
                              : Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  );
                }),

                const SizedBox(height: 40),

                // Bottom Hint
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Obx(
                    () => Text(
                      controller.subtitleText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
