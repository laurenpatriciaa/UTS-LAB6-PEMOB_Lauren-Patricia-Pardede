import 'package:flutter/material.dart';
import 'package:utspemob/data/quiz_data.dart';
import 'package:utspemob/models/quiz_model.dart';
import 'package:utspemob/screens/result_screen.dart';
import 'package:utspemob/widgets/quiz_header.dart';
import 'package:utspemob/widgets/quiz_option_button.dart';

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

    final currentQuestionIndex = widget.quizState.currentQuestionIndex;
    final totalQuestions = widget.quizState.questions.length;
    final score = widget.quizState.score;
    final questionsAnswered = widget.quizState.userAnswers.where((a) => a != null).length;
    final wrongAnswers = questionsAnswered - score;

    final questionToShow = currentQuestionIndex < totalQuestions
        ? widget.quizState.questions[currentQuestionIndex]
        : widget.quizState.questions.last;

    final double headerHeight = screenHeight * 0.22;
    final double cardTopPosition = screenHeight * 0.15;
    final double optionsTopPadding = screenHeight * 0.35;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F4F8),
      body: Stack(
        children: [
          QuizHeader(
            height: headerHeight,
            width: screenWidth,
            content: Container(),
          ),

          Positioned(
            top: cardTopPosition,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          score.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: const Color(0xFF4CAF50),
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Container(width: screenWidth * 0.1, height: 5, color: const Color(0xFF4CAF50)),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Question ${questionsAnswered + 1}/$totalQuestions',
                          style: TextStyle(
                            color: const Color(0xFF3B89A3),
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Container(width: screenWidth * 0.1, height: 5, color: const Color(0xFFF44336)),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          wrongAnswers.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: const Color(0xFFF44336),
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      questionToShow.questionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SmartifyFont',
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E4E6A),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...questionToShow.options.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String option = entry.value;
                          return QuizOptionButton(
                            text: option,
                            onPressed: () => _selectAnswer(idx),
                            optionIndex: idx,
                            selectedIndex: _temporarySelectedIndex,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.01, top: screenHeight * 0.04),
                    child: SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.085,
                      child: ElevatedButton(
                        onPressed: _goToNextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _temporarySelectedIndex != null
                              ? const Color(0xFF3B89A3)
                              : const Color(0xFFAAB8C2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: _temporarySelectedIndex != null ? 8 : 0,
                        ),
                        child: Text(
                          (questionsAnswered + 1) == totalQuestions ? 'Lihat Hasil' : 'Selanjutnya',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            color: Colors.white,
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
