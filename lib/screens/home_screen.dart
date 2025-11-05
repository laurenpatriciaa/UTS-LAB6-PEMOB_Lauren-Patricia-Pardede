import 'package:flutter/material.dart';
import 'package:utspemob/widgets/play_button.dart';
import 'package:utspemob/widgets/circle_widgets.dart';
import 'package:utspemob/data/quiz_data.dart'; 
import 'package:utspemob/models/quiz_model.dart';
import 'package:utspemob/screens/quiz_screen.dart';

const String _imageAssetPath = 'assets/logo.png';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onPlayButtonPressed() {
    final userName = _nameController.text.trim().isEmpty
        ? 'Pemain'
        : _nameController.text.trim();

    final QuizState newQuizState = QuizState(
      questions: dummyQuestions,
      userName: userName,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizScreen(quizState: newQuizState),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF3F9ED1),
        ),
        child: Stack(
          children: [
            Positioned(top: screenHeight * 0.70, left: screenWidth * -0.15, child: Opacity(opacity: 0.2, child: CircleWidget(size: screenWidth * 0.5))),
            Positioned(top: screenHeight * 0.45, right: screenWidth * -0.1, child: Opacity(opacity: 0.2, child: CircleWidget(size: screenWidth * 0.4))),
            Positioned(top: screenHeight * 0.85, right: screenWidth * -0.15, child: Opacity(opacity: 0.2, child: CircleWidget(size: screenWidth * 0.5))),
            Positioned(top: screenHeight * 0.58, left: screenWidth * 0.05, child: Opacity(opacity: 0.2, child: CircleWidget(size: screenWidth * 0.15))),
            Positioned(top: screenHeight * 0.1, left: screenWidth * -0.05, child: Opacity(opacity: 0.2, child: CircleWidget(size: screenWidth * 0.3))),
            Positioned(top: screenHeight * 0.05, right: screenWidth * 0.1, child: Opacity(opacity: 0.2, child: CircleWidget(size: screenWidth * 0.15))),

            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      _imageAssetPath,
                      height: screenHeight * 0.4,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Smartify',
                      style: TextStyle(
                        fontFamily: 'SmartifyFont',
                        fontSize: screenWidth * 0.14,
                        color: const Color(0xFF2E4E6A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Masukkan nama anda',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Container(
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 7,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _nameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.08),
                    PlayButton(
                      onPressed: _onPlayButtonPressed,
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.1,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: screenWidth * 0.18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
