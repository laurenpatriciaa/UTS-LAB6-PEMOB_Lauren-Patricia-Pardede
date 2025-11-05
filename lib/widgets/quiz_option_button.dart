import 'package:flutter/material.dart';

class QuizOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final int optionIndex;
  final int? selectedIndex;
  final bool isAnswerSubmitted;
  final int? correctAnswerIndex;

  const QuizOptionButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.optionIndex,
    required this.selectedIndex,
    this.isAnswerSubmitted = false,
    this.correctAnswerIndex,
  });

  Color _getBackgroundColor() {
    if (!isAnswerSubmitted) {
      return optionIndex == selectedIndex ? const Color(0xFF3B89A3) : Colors.white;
    } else {
      if (optionIndex == correctAnswerIndex) {
        return const Color(0xFF4CAF50);
      } else if (optionIndex == selectedIndex && optionIndex != correctAnswerIndex) {
        return const Color(0xFFF44336);
      }
      return Colors.white;
    }
  }

  Color _getTextColor() {
    final isHighlighted = (optionIndex == selectedIndex && !isAnswerSubmitted) ||
        (isAnswerSubmitted && (optionIndex == correctAnswerIndex || optionIndex == selectedIndex));

    if (isHighlighted) return Colors.white;
    return const Color(0xFF2E4E6A);
  }

  IconData _getIcon() {
    if (!isAnswerSubmitted) {
      return optionIndex == selectedIndex ? Icons.check_circle : Icons.radio_button_off;
    } else {
      if (optionIndex == correctAnswerIndex) {
        return Icons.check_circle;
      } else if (optionIndex == selectedIndex && optionIndex != correctAnswerIndex) {
        return Icons.cancel;
      }
      return Icons.radio_button_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bgColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final icon = _getIcon();

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
      width: screenWidth * 0.80,
      height: screenHeight * 0.09,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15.0),
        color: bgColor,
        border: Border.all(
          color: bgColor == Colors.white ? const Color(0xFFE0E0E0) : bgColor,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAnswerSubmitted ? null : onPressed,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'SmartifyFont',
                      fontSize: screenWidth * 0.05,
                      color: textColor,
                      fontWeight: isAnswerSubmitted || optionIndex == selectedIndex ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                Icon(
                  icon,
                  color: textColor,
                  size: screenWidth * 0.06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
