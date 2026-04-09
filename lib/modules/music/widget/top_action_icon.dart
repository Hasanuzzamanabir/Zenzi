import 'package:flutter/material.dart';
import 'package:zenzi/core/theme/app_colors.dart';

class TopActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const TopActionIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFD9A15F),
        ),
        child: Icon(icon, color: AppColors.risingtext, size: 18),
      ),
    );
  }
}
