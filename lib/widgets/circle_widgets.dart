import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double size;
  final Color color; 
  
  const CircleWidget({super.key, this.size = 100, this.color = Colors.white});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}