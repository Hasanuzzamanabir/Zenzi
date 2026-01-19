import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFD9A15F).withOpacity(0.18), // soft outer circle
      ),
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFD9A15F),
        ),
        child: const Center(
          child: Icon(Icons.pause, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
