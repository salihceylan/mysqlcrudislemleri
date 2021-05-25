import 'package:flutter/material.dart';
import 'veriler.dart';

import 'quiz.dart';
import 'result.dart';

class QuizLecture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizLectureState();
  }
}

class _QuizLectureState extends State<QuizLecture> {
  var _questionIndex = 0;
  int score = 0;

  void _answerQuestion(int answerValue) {
    setState(() {
      score += answerValue;
      _questionIndex++;
    });

    if (_questionIndex < Veriler.questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
      ),
      body: _questionIndex < Veriler.questions.length
          ? Quiz(
              answerQuestion: (int value) => _answerQuestion(value),
              questionIndex: _questionIndex,
            )
          : Result(score: score),
    );
  }
}
