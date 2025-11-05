import 'package:flutter/material.dart';
import 'package:utspemob/models/quiz_model.dart';
import 'package:utspemob/widgets/theme_toggle_button.dart';
import 'package:utspemob/main.dart';

class ReviewScreen extends StatelessWidget {
  final QuizState quizState;

  const ReviewScreen({
    super.key,
    required this.quizState,
  });

  Widget _buildReviewOption({
    required String optionText,
    required bool isCorrectAnswer,
    required bool isUserSelected,
    required double screenWidth,
    required Color baseBgColor,
    required Color baseTextColor,
    required Color correctGreen,
    required Color wrongRed,
    required Color primaryBlue,
  }) {
    Color bgColor = baseBgColor;
    Color iconColor = primaryBlue;
    IconData icon = Icons.radio_button_off;
    Color borderColor = baseBgColor;
    FontWeight fontWeight = FontWeight.normal;
    Color currentTextColor = baseTextColor;

    if (isCorrectAnswer) {
      bgColor = correctGreen;
      iconColor = Colors.white;
      icon = Icons.check_circle;
      borderColor = correctGreen;
      fontWeight = FontWeight.bold;
      currentTextColor = Colors.white;
    } else if (isUserSelected) {
      bgColor = wrongRed;
      iconColor = Colors.white;
      icon = Icons.cancel;
      borderColor = wrongRed;
      fontWeight = FontWeight.bold;
      currentTextColor = Colors.white;
    } else {
      borderColor = baseBgColor;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      width: screenWidth * 0.90,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.035),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              optionText,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: currentTextColor,
                fontWeight: fontWeight,
                fontFamily: 'DM Sans',
              ),
            ),
          ),
          Icon(
            icon,
            color: iconColor,
            size: screenWidth * 0.05,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final questions = quizState.questions;
    final userAnswers = quizState.userAnswers;
    final colorScheme = Theme.of(context).colorScheme;
    final themeColors = Theme.of(context).extension<ThemeColors>() ?? ThemeColors.defaults;

    final Color primaryBlue = colorScheme.primary;
    final Color textColor = colorScheme.onSurface;
    final Color mainBgColor = colorScheme.background;
    final Color correctGreen = themeColors.scoreGreen;
    final Color wrongRed = themeColors.scoreRed;
    final Color cardBgColor = colorScheme.surface;

    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: AppBar(
        title: Text('Review Jawaban', style: TextStyle(color: colorScheme.onPrimary)),
        backgroundColor: primaryBlue,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        elevation: 0,
        actions: const [
          ThemeToggleButton(),
        ],
      ),
      body: ListView.builder(
        itemCount: questions.length,
        padding: EdgeInsets.all(screenWidth * 0.04),
        itemBuilder: (context, index) {
          final question = questions[index];
          final userAnswerIndex = userAnswers[index];
          final correctAnswerIndex = question.correctAnswerIndex;

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pertanyaan ${index + 1}',
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  question.questionText,
                  style: TextStyle(
                    fontFamily: 'SmartifyFont',
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.05,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 15),
                ...question.options.asMap().entries.map((entry) {
                  int optionIndex = entry.key;
                  String optionText = entry.value;

                  return _buildReviewOption(
                    optionText: optionText,
                    isCorrectAnswer: optionIndex == correctAnswerIndex,
                    isUserSelected: optionIndex == userAnswerIndex,
                    screenWidth: screenWidth,
                    baseBgColor: cardBgColor,
                    baseTextColor: textColor,
                    correctGreen: correctGreen,
                    wrongRed: wrongRed,
                    primaryBlue: primaryBlue,
                  );
                }).toList(),
                if (userAnswerIndex == null)
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.02),
                    child: Text(
                      'Anda belum menjawab soal ini.',
                      style: TextStyle(
                        color: colorScheme.error,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
