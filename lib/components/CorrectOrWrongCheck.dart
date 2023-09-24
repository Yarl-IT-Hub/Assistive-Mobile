import 'package:flutter/material.dart';

class CorrectOrWrong extends StatelessWidget {
  const CorrectOrWrong({
    Key? key,
    required this.isAnswerCheck,
    required this.correctAnswer,
    this.questionType,
  }) : super(key: key);

  final bool isAnswerCheck;
  final int correctAnswer;
  final int? questionType;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAnswerCheck,
      child: Positioned.fill(
        child: Padding(
          padding: EdgeInsets.all(questionType == 2 ? 3 : 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: correctAnswer == 1
                  ? Colors.green.withOpacity(0.5)
                  : Colors.red.withOpacity(0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: questionType == 2 ? 30 : 50,
                  image: AssetImage(correctAnswer == 1
                      ? 'assets/static/correct.png'
                      : 'assets/static/wrong.png'),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
