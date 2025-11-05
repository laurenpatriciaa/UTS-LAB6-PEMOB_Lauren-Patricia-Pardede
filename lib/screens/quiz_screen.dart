import 'package:flutter/material.dart';
import 'package:utspemob/models/quiz_model.dart';
import 'package:utspemob/screens/result_screen.dart';
import 'package:utspemob/widgets/quiz_header.dart';
import 'package:utspemob/widgets/quiz_option_button.dart';
import 'package:utspemob/widgets/theme_toggle_button.dart';
import '../main.dart';

class QuizScreen extends StatefulWidget {
  final QuizState quizState;

  const QuizScreen({super.key, required this.quizState});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _temporarySelectedIndex;

  @override
  void initState() {
    super.initState();
    final currentQuestionIndex = widget.quizState.currentQuestionIndex;
    if (currentQuestionIndex < widget.quizState.questions.length) {
      _temporarySelectedIndex = widget.quizState.userAnswers[currentQuestionIndex];
    }
  }

  void _selectAnswer(int selectedIndex) {
    setState(() {
      _temporarySelectedIndex = selectedIndex;
    });
  }

  void _goToNextQuestion() {
    final currentQuestionIndex = widget.quizState.currentQuestionIndex;

    if (_temporarySelectedIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jawaban Anda terlebih dahulu!')),
      );
      return;
    }

    widget.quizState.userAnswers[currentQuestionIndex] = _temporarySelectedIndex;

    if (currentQuestionIndex + 1 >= widget.quizState.questions.length) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultScreen(quizState: widget.quizState),
        ),
      );
    } else {
      setState(() {
        final nextQuestionIndex = currentQuestionIndex + 1;
        _temporarySelectedIndex = widget.quizState.userAnswers[nextQuestionIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final colorScheme = Theme.of(context).colorScheme;
    final themeColors = Theme.of(context).extension<ThemeColors>() ?? ThemeColors.defaults;

    final currentQuestionIndex = widget.quizState.currentQuestionIndex;
    final totalQuestions = widget.quizState.questions.length;
    final score = widget.quizState.score;
    final questionsAnswered = widget.quizState.userAnswers.where((a) => a != null).length;
    final wrongAnswers = questionsAnswered - score;

    final questionToShow = currentQuestionIndex < totalQuestions
        ? widget.quizState.questions[currentQuestionIndex]
        : widget.quizState.questions.last;

    final double headerHeight = screenHeight * 0.18; // dikurangi
    final double cardTopPosition = screenHeight * 0.12; // dikurangi
    final double optionsTopPadding = screenHeight * 0.3; // dikurangi

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          QuizHeader(
            height: headerHeight,
            width: screenWidth,
            content: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ThemeToggleButton(),
                  SizedBox(width: screenWidth * 0.02),
                ],
              ),
            ),
          ),
          Positioned(
            top: cardTopPosition,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: colorScheme.surface,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04), // padding dikurangi
                child: Column(
                  children: [
                    if (widget.quizState.userName.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.008),
                        child: Text(
                          'Halo, ${widget.quizState.userName}!',
                          style: TextStyle(
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          score.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: themeColors.scoreGreen,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Container(width: screenWidth * 0.09, height: 4, color: themeColors.scoreGreen),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Question ${questionsAnswered + 1}/$totalQuestions',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Container(width: screenWidth * 0.09, height: 4, color: themeColors.scoreRed),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          wrongAnswers.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: themeColors.scoreRed,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015), // jarak dikurangi
                    Text(
                      questionToShow.questionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SmartifyFont',
                        fontSize: screenWidth * 0.05, // font size dikurangi
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: optionsTopPadding),
            child: SizedBox(
              width: screenWidth,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.01),
                          ...questionToShow.options.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                              child: QuizOptionButton(
                                text: option,
                                onPressed: () => _selectAnswer(idx),
                                optionIndex: idx,
                                selectedIndex: _temporarySelectedIndex,
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.01, top: screenHeight * 0.02),
                    child: SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.085,
                      child: ElevatedButton(
                        onPressed: _goToNextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: _temporarySelectedIndex != null ? 8 : 4,
                          foregroundColor: colorScheme.onSecondary,
                        ),
                        child: Text(
                          (questionsAnswered + 1) == totalQuestions ? 'Lihat Hasil' : 'Selanjutnya',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            color: colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
