import 'package:flutter/material.dart';
import 'veriler.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final Function(int) answerQuestion;

  Quiz({
    required this.answerQuestion,
    this.questionIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          Veriler.questions[questionIndex]['questionText'].toString(),
        ),
        ...(Veriler.questions[questionIndex]['answers']
                as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            selectHandler: () => answerQuestion(answer['score'] as int),
            answer: answer['answerText'] as String,
          );
        }).toList()
      ],
    );
  }
}
