import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double size;
  const CircleWidget({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}