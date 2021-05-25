import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Result extends StatelessWidget {
  final int score;
  String _scoreText = " ";

  String get scoreText {
    _scoreText = score < 240
        ? "You are so bad..."
        : score < 270
            ? "You are light..."
            : score <= 300
                ? "You're awesome"
                : " ";
    return _scoreText;
  }

  Result({Key? key, required this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$scoreText \n\n\n Your Score: $score'),
    );
  }
}
