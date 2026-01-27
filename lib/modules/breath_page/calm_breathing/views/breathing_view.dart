import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/values/app_assets.dart';
import '../controllers/breathing_controller.dart';
import '../painters/breathing_painter.dart';

class CalmBreathingView extends StatelessWidget {
  const CalmBreathingView({super.key});

  @override
  Widget build(BuildContext context) {
    final CalmBreathingController controller = Get.put(
      CalmBreathingController(),
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
          // 1. Background Gradient (Blue -> Purple)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF5B6EDC), // Blue (approx)
                  Color(0xFF6B3FA0), // Purple (approx)
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
                // If InPhase: animation value (0->1)
                // If Hold: 1.0
                // If Reset: 0.0
                if (controller.phase == BreathPhase.inPhase) {
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
                    painter: CalmBreathingPainter(animationValue: visualValue),
                    // Static Wave graphic (White/Blue mix?) user said "Wave image as shown"
                    // Screenshot shows a blue-ish wave on the teal bg. Here bg is blue/purple.
                    // Let's use a White/Cyan wave icon to stand out or Dark Blue?
                    // "Center content: A STATIC IMAGE (wave image as shown)... perfectly centered"
                    // Using standard icon for now as placeholder for "Wave Image".
                    child: Center(
                      child: Image.asset(
                        AppAssets.calm_breath,
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
                // Hide timer if reset/done
                if (controller.phase == BreathPhase.reset &&
                    controller.cycle >= controller.totalCycles) {
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

                // Box Breathing Subtitle
                Text(
                  "Box Breathing", // Kept per request even if logic is 5-5-0
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 30),

                // Cycle Dots
                Obx(() {
                  final currentCycle = controller.cycle;
                  final total = controller.totalCycles;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(total, (index) {
                      final bool isActive = index < currentCycle;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 8,
                        height: 8,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Obx(
                    () => Text(
                      controller.subtitleText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
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
