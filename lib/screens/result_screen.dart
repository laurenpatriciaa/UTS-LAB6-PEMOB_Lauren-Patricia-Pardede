import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utspemob/models/quiz_model.dart';
import 'package:utspemob/widgets/circle_widgets.dart';
import 'package:utspemob/screens/home_screen.dart';
import 'package:utspemob/widgets/score_circle.dart';
import 'package:utspemob/screens/review_answer.dart';
import 'package:utspemob/widgets/theme_toggle_button.dart';
import '../main.dart';

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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReviewScreen(quizState: quizState),
      ),
    );
  }

  Widget _buildStatItem({
    required Color color,
    required String value,
    required String label,
    required double screenWidth,
    required double screenHeight,
    required Color labelColor,
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
            color: labelColor,
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
    required Color labelColor,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
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
            color: labelColor,
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
    final colorScheme = Theme.of(context).colorScheme;
    final themeColors = Theme.of(context).extension<ThemeColors>() ?? ThemeColors.defaults;

    final double maxContentWidth = 600;
    final bool isWideScreen = screenWidth > maxContentWidth;
    final double adjustedScreenWidth = isWideScreen ? maxContentWidth : screenWidth;

    final String actualScore = _totalScorePoints.toString();
    final double completionValue = _totalQuestions > 0 ? (quizState.userAnswers.where((a) => a != null).length / _totalQuestions) * 100 : 100;
    final String completion = completionValue.round().toString() + '%';
    final String totalQ = _totalQuestions.toString().padLeft(2, '0');
    final String correct = _correctAnswers.toString().padLeft(2, '0');
    final String wrong = _wrongAnswers.toString().padLeft(2, '0');

    final double innerContainerWidth = adjustedScreenWidth * (337 / 360);
    final double innerContainerHeight = screenHeight * (673 / 717);
    final double scoreCircleBaseSize = adjustedScreenWidth * (116 / 360);

    final Color primaryBlue = colorScheme.primary;
    final Color correctGreen = themeColors.scoreGreen;
    final Color wrongRed = themeColors.scoreRed;
    final Color homePurple = themeColors.homeButtonColor;
    final Color mainBgColor = colorScheme.background;
    final Color cardColor = themeColors.cardColor;
    final Color onCardText = colorScheme.onBackground;

    return Scaffold(
      backgroundColor: mainBgColor,
      body: Center(
        child: SizedBox(
          width: adjustedScreenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              Positioned(
                left: adjustedScreenWidth * (11 / 360),
                top: screenHeight * (26 / 717),
                child: Container(
                  width: innerContainerWidth,
                  height: innerContainerHeight,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        width: innerContainerWidth,
                        height: innerContainerHeight * (334 / 673),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: innerContainerHeight * (30 / 673),
                        left: innerContainerWidth * (10 / 337),
                        right: innerContainerWidth * (10 / 337),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary, size: 30),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const ThemeToggleButton(),
                          ],
                        ),
                      ),
                      Positioned(top: innerContainerHeight * (88/673), left: innerContainerWidth * (279/337) - adjustedScreenWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: adjustedScreenWidth * 0.18, color: colorScheme.onPrimary))),
                      Positioned(top: innerContainerHeight * (-34/673), left: innerContainerWidth * (78/337) - adjustedScreenWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: adjustedScreenWidth * 0.18, color: colorScheme.onPrimary))),
                      Positioned(top: innerContainerHeight * (16/673), left: innerContainerWidth * (207/337) - adjustedScreenWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: adjustedScreenWidth * 0.08, color: colorScheme.onPrimary))),
                      Positioned(top: innerContainerHeight * (69/673), left: innerContainerWidth * (-45/337) - adjustedScreenWidth * 0.05, child: Opacity(opacity: 0.25, child: CircleWidget(size: adjustedScreenWidth * 0.18, color: colorScheme.onPrimary))),
                      Positioned(
                        left: innerContainerWidth * (82 / 337),
                        top: innerContainerHeight * (56 / 673),
                        child: ScoreCircle(
                          score: int.parse(actualScore),
                          circleSize: scoreCircleBaseSize,
                          primaryColor: primaryBlue,
                          onPrimaryColor: colorScheme.onPrimary,
                          backgroundColor: cardColor,
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
                              color: cardColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
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
                                      color: primaryBlue,
                                      value: completion,
                                      label: 'Completion',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                      labelColor: onCardText,
                                    ),
                                    _buildStatItem(
                                      color: primaryBlue,
                                      value: totalQ,
                                      label: 'Total Question',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                      labelColor: onCardText,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStatItem(
                                      color: correctGreen,
                                      value: correct,
                                      label: 'Correct',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                      labelColor: onCardText,
                                    ),
                                    _buildStatItem(
                                      color: wrongRed,
                                      value: wrong,
                                      label: 'Wrong',
                                      screenWidth: innerContainerWidth,
                                      screenHeight: innerContainerHeight,
                                      labelColor: onCardText,
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
                              iconBackgroundColor: primaryBlue,
                              screenWidth: innerContainerWidth,
                              labelColor: onCardText,
                            ),
                            _buildActionButton(
                              icon: Icons.remove_red_eye_outlined,
                              label: 'Review Answer',
                              onPressed: () => _reviewAnswer(context),
                              iconBackgroundColor: CupertinoColors.systemOrange,
                              screenWidth: innerContainerWidth,
                              labelColor: onCardText,
                            ),
                            _buildActionButton(
                              icon: Icons.home,
                              label: 'Home',
                              onPressed: () => _goToHome(context),
                              iconBackgroundColor: homePurple,
                              screenWidth: innerContainerWidth,
                              labelColor: onCardText,
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
