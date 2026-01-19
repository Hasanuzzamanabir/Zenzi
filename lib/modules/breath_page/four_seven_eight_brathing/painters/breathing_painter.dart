import 'dart:math';
import 'package:flutter/material.dart';

class FourSevenEightBreathingPainter extends CustomPainter {
  final double animationValue; // 0.0 to 1.0 (Scale factor for inner circle)

  FourSevenEightBreathingPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2.5;

    // 1. Draw Outer Circle (Fixed Stroke)
    final outerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, maxRadius, outerPaint);

    // 2. Draw Inner Circle (Animated Scale, Stroke)
    // Scale Logic:
    // Min size: 50% of maxRadius
    // Max size: 75% of maxRadius (visually pleasing gap)
    final double minInnerRadius = maxRadius * 0.50;
    final double maxInnerRadius = maxRadius * 0.75;

    final double currentInnerRadius =
        minInnerRadius + (maxInnerRadius - minInnerRadius) * animationValue;

    final innerPaint = Paint()
      ..color = Colors.white
          .withValues(
            alpha: 0.5,
          ) // Slightly transparent stroke? Or solid? Screenshot looks solid white or light.
      // Prompt says "Inner circle: white stroke".
      // Screenshot looks like it might have a faint fill, but strictly user said: "Inner circle: white stroke".
      // I will add a very faint fill to make it look "full" but minimal, and a solid stroke.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Slightly thicker than outer per screenshot

    // Optional: Faint fill to give it body like the screenshot?
    // Screenshot shows a filled circle area for the "Zzz" to sit on?
    // Actually screenshot shows the Zzz looks like it's floating.
    // Let's add a very subtle fill.
    final innerFillPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, currentInnerRadius, innerFillPaint);
    canvas.drawCircle(center, currentInnerRadius, innerPaint);
  }

  @override
  bool shouldRepaint(covariant FourSevenEightBreathingPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
