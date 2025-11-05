import 'package:flutter/material.dart';

class AnswerIndicator extends StatelessWidget {
  final bool isCorrect;
  final double size;

  const AnswerIndicator({
    super.key,
    required this.isCorrect,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isCorrect ? Icons.check : Icons.close,
        color: Colors.white,
        size: size * 0.6,
      ),
    );
  }
}