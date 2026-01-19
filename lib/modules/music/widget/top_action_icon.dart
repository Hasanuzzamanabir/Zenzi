import 'package:flutter/material.dart';

class TopActionIcon extends StatelessWidget {
  final IconData icon;

  const TopActionIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFD9A15F),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
