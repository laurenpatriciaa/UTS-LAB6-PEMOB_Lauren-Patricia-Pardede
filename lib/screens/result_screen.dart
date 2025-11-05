import 'package:flutter/material.dart';
import 'package:utspemob/models/quiz_model.dart';
import 'package:utspemob/widgets/circle_widgets.dart';
import 'package:utspemob/screens/home_screen.dart';
import 'package:utspemob/widgets/score_circle.dart';

class ResultScreen extends StatelessWidget {
  final QuizState quizState;

  const ResultScreen({super.key, required this.quizState});

  int get _correctAnswers => quizState.score;
  int get _totalQuestions => quizState.questions.length;
  int get _wrongAnswers => _totalQuestions - _correctAnswers;

  int get _totalScorePoints {
    if (_totalQuestions == 0) return 0;
    return (_correctAnswers * 100) ~/ _totalQuestions;
  }

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _playAgain(BuildContext context) {
    _goToHome(context);
  }

  void _reviewAnswer(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur Review Jawaban Belum Diimplementasikan!')),
    );
  }

  Widget _buildStatItem({
    required Color color,
    required String value,
    required String label,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.02),
              child: Icon(Icons.circle, color: color, size: screenWidth * 0.033),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.w500,
                color: color,
                fontFamily: 'DM Sans',
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.005),
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            color: const Color(0xFF2B252C),
            fontWeight: FontWeight.w400,
            fontFamily: 'DM Sans',
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color iconBackgroundColor,
    required double screenWidth,
  }) {
    final double iconSize = screenWidth * 0.08;
    final double containerSize = screenWidth * 0.18;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(containerSize / 2),
            child: Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF2B252C),
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w400,
            fontFamily: 'DM Sans',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final String actualScore = _totalScorePoints.toString();
    final double completionValue = _totalQuestions > 0 ? (quizState.userAnswers.where((a) => a != null).length / _totalQuestions) * 100 : 100;
    final String completion = completionValue.round().toString() + '%';

    final String totalQ = _totalQuestions.toString().padLeft(2, '0');
    final String correct = _correctAnswers.toString().padLeft(2, '0');
    final String wrong = _wrongAnswers.toString().padLeft(2, '0');

    final double innerContainerWidth = screenWidth * (337 / 360);
    final double innerContainerHeight = screenHeight * (673 / 717);
    final double scoreCircleBaseSize = screenWidth * (116 / 360);

    return Scaffold(
      backgroundColor: const Color(0xFFECF8FF),
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFECF8FF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                left: screenWidth * (11 / 360),
                top: screenHeight * (26 / 717),
                child: Container(
                  width: innerContainerWidth,
                  height: innerContainerHeight,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        width: innerContainerWidth,
                        height: innerContainerHeight * (334 / 673),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF3F9ED1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: innerContainerHeight * (30 / 673),
                        left: innerContainerWidth * (10 / 337),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Positioned(top: innerContainerHeight * (88/673), left: innerContainerWidth * (279/337) - innerContainerWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: innerContainerWidth * 0.18))),
                      Positioned(top: innerContainerHeight * (-34/673), left: innerContainerWidth * (78/337) - innerContainerWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: innerContainerWidth * 0.18))),
                      Positioned(top: innerContainerHeight * (16/673), left: innerContainerWidth * (207/337) - innerContainerWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: innerContainerWidth * 0.08))),
                      Positioned(top: innerContainerHeight * (69/673), left: innerContainerWidth * (-45/337) - innerContainerWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: innerContainerWidth * 0.18))),
                      Positioned(
                        left: innerContainerWidth * (82 / 337),
                        top: innerContainerHeight * (56 / 673),
                        child: ScoreCircle(
                          score: int.parse(actualScore),
                          circleSize: scoreCircleBaseSize,
                        ),
                      ),
                      Positioned(
                        left: innerContainerWidth * (17 / 337),
                        top: innerContainerHeight * (252 / 673),
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: innerContainerWidth * (305 / 337),
                            height: innerContainerHeight * (159 / 673),
                            padding: EdgeInsets.symmetric(
                              horizontal: innerContainerWidth * 0.05,
                              vertical: innerContainerHeight * 0.03,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x7F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStatItem(
                                      color: const Color(0xFF3F9ED1),
                                      value: completion,
                                      label: 'Completion',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                    ),
                                    _buildStatItem(
                                      color: const Color(0xFF3F9ED1),
                                      value: totalQ,
                                      label: 'Total Question',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStatItem(
                                      color: const Color(0xFF1E8334),
                                      value: correct,
                                      label: 'Correct',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                    ),
                                    _buildStatItem(
                                      color: const Color(0xFFF93838),
                                      value: wrong,
                                      label: 'Wrong',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: innerContainerHeight * (460 / 673),
                        left: innerContainerWidth * (30 / 337),
                        right: innerContainerWidth * (30 / 337),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildActionButton(
                              icon: Icons.refresh,
                              label: 'Play Again',
                              onPressed: () => _playAgain(context),
                              iconBackgroundColor: const Color(0xFF3F9ED1),
                              screenWidth: innerContainerWidth,
                            ),
                            _buildActionButton(
                              icon: Icons.remove_red_eye_outlined,
                              label: 'Review Answer',
                              onPressed: () => _reviewAnswer(context),
                              iconBackgroundColor: const Color(0xFF3F9ED1),
                              screenWidth: innerContainerWidth,
                            ),
                            _buildActionButton(
                              icon: Icons.home,
                              label: 'Home',
                              onPressed: () => _goToHome(context),
                              iconBackgroundColor: const Color(0xFFAD89E7),
                              screenWidth: innerContainerWidth,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
