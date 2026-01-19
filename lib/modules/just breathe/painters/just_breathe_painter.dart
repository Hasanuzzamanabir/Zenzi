import 'dart:math';
import 'package:flutter/material.dart';

class JustBreathePainter extends CustomPainter {
  final double animationValue; // 0.0 to 1.0
  final Color dotColor;
  final double dotRadius;
  final double strokeWidth;

  JustBreathePainter({
    required this.animationValue,
    this.dotColor = Colors.black,
    this.dotRadius = 8.0,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Base radius logic
    final double maxRadius = min(size.width, size.height) / 2.2;

    // Paint setup
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.28)
      ..style = PaintingStyle.fill;

    // 1. Outer Circle (Fixed)
    canvas.drawCircle(center, maxRadius, strokePaint);

    // 2. Inner Circle (Animated)
    // Animates between ~40% and ~75% of maxRadius
    final double minInner = maxRadius * 0.45;
    final double maxInner = maxRadius * 0.70; // Close to outer
    final double currentInnerRadius =
        minInner + (maxInner - minInner) * animationValue;

    canvas.drawCircle(center, currentInnerRadius, strokePaint);

    final double dotRadiusDist = maxRadius * 0.90;
    const int dotCount = 8;
    for (int i = 0; i < dotCount; i++) {
      final double angle = (2 * pi / dotCount) * i;
      final double dx = center.dx + dotRadiusDist * cos(angle);
      final double dy = center.dy + dotRadiusDist * sin(angle);

      // Use provided dotRadius
      canvas.drawCircle(Offset(dx, dy), dotRadius, dotPaint);
    }

    final double squareW =
        (maxInner * 2) * 0.22; // Slightly larger matching crop
    final Rect squareRect = Rect.fromCenter(
      center: center,
      width: squareW,
      height: squareW,
    );

    // "Color: soft white" -> Screenshot shows semi-transparent white.
    // No blur. Clean edges.
    // Fill between inner circle and square
    final fillBetweenPaint = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..style = PaintingStyle.fill;

    // Draw fill between inner circle and square (as a filled circle, under the square)
    canvas.drawCircle(center, currentInnerRadius, fillBetweenPaint);

    final mainSquarePaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..style = PaintingStyle.fill;

    // "Perfect square" with slight rounding
    canvas.drawRRect(
      RRect.fromRectAndRadius(squareRect, const Radius.circular(4)),
      mainSquarePaint,
    );
  }

  @override
  bool shouldRepaint(covariant JustBreathePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.dotColor != dotColor ||
        oldDelegate.dotRadius != dotRadius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
