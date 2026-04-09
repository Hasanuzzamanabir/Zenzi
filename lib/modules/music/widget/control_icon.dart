import 'package:flutter/material.dart';

class ControlIcon extends StatelessWidget {
  final bool isForward;
  final VoidCallback? onTap;

  const ControlIcon({super.key, this.isForward = false, this.onTap});

  const ControlIcon.action({
    super.key,
    required this.onTap,
    this.isForward = false,
  });

  @override
  Widget build(BuildContext context) {
    final IconData iconData = isForward ? Icons.forward_10 : Icons.replay_10;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(iconData, color: const Color(0xFFD59A52), size: 30),
      ),
    );
  }
}
