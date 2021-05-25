import 'package:flutter/material.dart';
import 'package:mysqlcrudislemleri/maxslectures/expenceplanner/expenceplanner.dart';
import 'package:mysqlcrudislemleri/maxslectures/quizlecture/quizlecture.dart';

class MaxsLectures extends StatelessWidget {
  final String title;
  MaxsLectures({required this.title}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizLecture())),
                  child: Text("Quiz Lecture"))),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: OutlinedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExpencePlanner())),
                  child: Text("Expence Planner"))),
        ],
      ),
    );
  }
}
