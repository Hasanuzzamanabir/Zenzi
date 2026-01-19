import 'package:flutter/material.dart';

class ControlIcon extends StatelessWidget {
  final bool isForward;
  const ControlIcon({super.key, this.isForward = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.replay_10, color: const Color(0xFFD59A52), size: 30),
        //const Text('15', style: TextStyle(fontSize: 11)),
      ],
    );
  }
}
