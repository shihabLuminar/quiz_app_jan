import 'package:flutter/material.dart';
import 'package:quiz_app_jan/controller/quiz_screen_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.righAnswerCount});
  final int righAnswerCount;

  @override
  Widget build(BuildContext context) {
    final percentage =
        (righAnswerCount / QuizScreenController.flutterQuestions.length) * 100;
    return Scaffold(
      body: Center(
        child: Text("Your score is ${percentage.round()} % "),
      ),
    );
  }
}
