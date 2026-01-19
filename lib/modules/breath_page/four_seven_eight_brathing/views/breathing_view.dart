import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/modules/breath_page/four_seven_eight_brathing/controllers/breathing_controller.dart';
import 'package:zenzi/modules/breath_page/four_seven_eight_brathing/painters/breathing_painter.dart';

class FourSevenEightBreathingView extends StatelessWidget {
  const FourSevenEightBreathingView({super.key});

  @override
  Widget build(BuildContext context) {
    final FourSevenEightBreathingController controller = Get.put(
      FourSevenEightBreathingController(),
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient (Teal to Green)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6dd5ed), // Light Blue/Teal top
                  Color(0xFF2193b0), // Deep Teal/Green bottom
                  // Or closer to screenshot:
                  // Top: Light Teal/Cyan
                  // Bottom: Dark Greenish Teal
                ],
              ),
            ),
          ),
          // Let's adjust gradient to match screenshot better
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF81D4FA), // Light Cyan
                  Color(0xFF26A69A), // Teal Green
                  Color(0xFF00695C), // Deep Teal
                ],
                stops: [0.0, 0.6, 1.0],
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
                  visualValue = 0.0;
                }

                return SizedBox(
                  width: 320,
                  height: 320,
                  child: CustomPaint(
                    painter: FourSevenEightBreathingPainter(
                      animationValue: visualValue,
                    ),
                    // Static "Zzz" in center
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          // Zzz Graphic (using Text for crisp look as requested)
                          // Creating a Zzz shape or using icon
                          // Screenshot shows "Z z Z" in blue.
                          Text(
                            "z\n   Z\n      Z",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1), // Deep Blue Zzz
                              height: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Top Right Cycle Count
          Positioned(
            top: 50,
            right: 20,
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

          // 4. Large Timer at Top Center
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
                    fontSize: 56,
                    fontWeight: FontWeight.w300,
                  ),
                );
              }),
            ),
          ),

          // 5. Bottom Section
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
                  "Box Breathing",
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

          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
