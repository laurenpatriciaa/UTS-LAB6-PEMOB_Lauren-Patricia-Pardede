class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizState {
  final List<Question> questions;
  String userName;
  List<int?> userAnswers;

  QuizState({
    required this.questions,
    this.userName = 'Pemain',
  }) : userAnswers = List.filled(questions.length, null);

  int get score {
    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] != null && userAnswers[i] == questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }
    return correctCount;
  }

  int get currentQuestionIndex =>
      userAnswers.where((answer) => answer != null).length < questions.length
          ? userAnswers.where((answer) => answer != null).length
          : questions.length - 1;

  bool get isQuizFinished =>
      userAnswers.where((answer) => answer != null).length >= questions.length;
}
