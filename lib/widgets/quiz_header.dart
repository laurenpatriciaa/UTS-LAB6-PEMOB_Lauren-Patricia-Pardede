import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  final double height;
  final double width;
  final Widget content;

  const QuizHeader({
    super.key,
    required this.height,
    required this.width,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xFF3F9ED1), 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: content,
    );
  }
}