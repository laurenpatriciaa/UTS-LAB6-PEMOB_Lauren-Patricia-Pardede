import 'package:utspemob/models/quiz_model.dart';

const List<Question> dummyQuestions = [
  Question(
    questionText: 'Siapakah penemu bahasa pemrograman Dart?',
    options: ['Bjarne Stroustrup', 'Dennis Ritchie', 'Lars Bak dan Kasper Lund', 'James Gosling'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Tahun berapakah Flutter pertama kali dirilis?',
    options: ['2015', '2017', '2018', '2019'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Widget mana yang digunakan untuk membuat tampilan yang dapat di-scroll?',
    options: ['Container', 'Row', 'ListView', 'Text'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Apa fungsi utama dari `setState()` di Flutter?',
    options: ['Mengubah warna background', 'Memindahkan widget', 'Membangun ulang (rebuild) widget dan memperbarui UI', 'Menghapus widget dari tree'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Pada pola M-V-C, apa kepanjangan dari 'V'?",
    options: ['Variable', 'View', 'Validator', 'Value'],
    correctAnswerIndex: 1,
  ),
];