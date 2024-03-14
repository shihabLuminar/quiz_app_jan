// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quiz_app_jan/controller/quiz_screen_controller.dart';
import 'package:quiz_app_jan/core/constants/color_constants.dart';
import 'package:quiz_app_jan/view/result_screen/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQstnIndex = 0;
  int? selectedAnswerIndex;
  int rightAnswersCount = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.primaryBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConstants.darkGrey),
                child: Text(
                  QuizScreenController
                      .flutterQuestions[currentQstnIndex].question,
                  style: TextStyle(
                      color: ColorConstants.primaryWhite, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: List.generate(
                    QuizScreenController
                        .flutterQuestions[currentQstnIndex].optionsList.length,
                    (index) => InkWell(
                          onTap: () {
                            if (selectedAnswerIndex == null) {
                              selectedAnswerIndex = index;

                              if (selectedAnswerIndex ==
                                  QuizScreenController
                                      .flutterQuestions[currentQstnIndex]
                                      .correctAnswerIndex) {
                                rightAnswersCount++;
                              }
                              print(rightAnswersCount);

                              setState(() {});
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: buldColor(index),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    QuizScreenController
                                        .flutterQuestions[currentQstnIndex]
                                        .optionsList[index],
                                    style: TextStyle(
                                        color: ColorConstants.primaryWhite,
                                        fontSize: 18),
                                  ),
                                  Icon(
                                    buildIcons(index),
                                    color: buldColor(index),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if (currentQstnIndex <
                      QuizScreenController.flutterQuestions.length - 1) {
                    currentQstnIndex++;
                    selectedAnswerIndex = null;
                    setState(() {});
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            righAnswerCount: rightAnswersCount,
                          ),
                        ));
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.primaryBlue),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: ColorConstants.primaryWhite, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //build  color

  Color buldColor(int index) {
    if (index ==
            QuizScreenController
                .flutterQuestions[currentQstnIndex].correctAnswerIndex &&
        selectedAnswerIndex != null) {
      // to show right answr if  selected answer is not null
      return Colors.green;
    } else if (index == selectedAnswerIndex) {
      // to show whether the selected asnwer is right or wrong
      if (selectedAnswerIndex ==
          QuizScreenController
              .flutterQuestions[currentQstnIndex].correctAnswerIndex) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      // to show the default color as grey
      return ColorConstants.primaryGrey;
    }
  }

  IconData? buildIcons(int index) {
    if (index ==
            QuizScreenController
                .flutterQuestions[currentQstnIndex].correctAnswerIndex &&
        selectedAnswerIndex != null) {
      return Icons.done;
    } else if (index == selectedAnswerIndex) {
      if (selectedAnswerIndex !=
          QuizScreenController
              .flutterQuestions[currentQstnIndex].correctAnswerIndex) {
        return Icons.close;
      }
    } else {
      return null;
    }
  }
}
