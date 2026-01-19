import 'dart:math';
import 'package:flutter/material.dart';

class BoxBreathingPainter extends CustomPainter {
  final double animationValue; // 0.0 to 1.0 (Scale)
  final double rotationValue; // 0.0 to 1.0 (Rotation full circle)

  BoxBreathingPainter({
    required this.animationValue,
    required this.rotationValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2.5;

    // 1. Draw Outer Circle (Stroke)
    final outerPaint = Paint()
      ..color = Colors.white
          .withValues(
            alpha: 0.1,
          ) // Using withValues for Dart 3 compatible opacity
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, maxRadius, outerPaint);

    // 2. Draw Rotating Dots
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const int dotCount = 8;
    const double dotRadius = 4.0;
    final double angleStep = (2 * pi) / dotCount;
    final double currentRotation = 2 * pi * rotationValue;

    for (int i = 0; i < dotCount; i++) {
      final double angle = (i * angleStep) + currentRotation;
      final double dx = center.dx + maxRadius * cos(angle);
      final double dy = center.dy + maxRadius * sin(angle);

      canvas.drawCircle(Offset(dx, dy), dotRadius, dotPaint);
    }

    // 3. Draw Inner Circle (Breathing)
    // Map animationValue (0.0 - 1.0) to radius range (e.g., 30% to 60% of maxRadius)
    // 0.0 -> small (exhale end), 0.5 -> medium, 1.0 -> large (inhale end)

    // Interpolate radius based on animation value
    // We want the inner circle to be responsive to the "breath"
    final double minInnerRadius = maxRadius * 0.4;
    final double maxInnerRadius = maxRadius * 0.85;
    final double currentInnerRadius =
        minInnerRadius + (maxInnerRadius - minInnerRadius) * animationValue;

    final innerPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              Colors.cyanAccent.withValues(alpha: 0.4),
              Colors.blue.withValues(alpha: 0.1),
            ],
          ).createShader(
            Rect.fromCircle(center: center, radius: currentInnerRadius),
          )
      ..style = PaintingStyle.fill;

    // Add a glow/stroke to inner circle
    final innerStrokePaint = Paint()
      ..color = Colors.cyanAccent.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, currentInnerRadius, innerPaint);
    canvas.drawCircle(center, currentInnerRadius, innerStrokePaint);

    // 4. Draw Center Square (Fixed size, styled)
    // Max inner radius is approx maxRadius * 0.85.
    // Diameter ~ 2 * 0.85 * maxRadius.
    // 20% of diameter => 0.4 * 0.85 * maxRadius => ~0.34 * maxRadius
    final double squareSize = maxRadius * 0.35;
    final Rect squareRect = Rect.fromCenter(
      center: center,
      width: squareSize,
      height: squareSize,
    );
    final RRect roundedSquare = RRect.fromRectAndRadius(
      squareRect,
      const Radius.circular(4.0),
    );

    // Shadow
    canvas.drawShadow(
      Path()..addRRect(roundedSquare),
      Colors.black.withValues(alpha: 0.3),
      4.0,
      true,
    );

    // Main Body
    final squarePaint = Paint()
      ..color = const Color(0xFFE0F7FA)
          .withValues(alpha: 0.9) // Soft Cyan/White
      ..style = PaintingStyle.fill;

    canvas.drawRRect(roundedSquare, squarePaint);

    // Subtle Inner Glow/Highlight (Stroke)
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(roundedSquare, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant BoxBreathingPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.rotationValue != rotationValue;
  }
}
