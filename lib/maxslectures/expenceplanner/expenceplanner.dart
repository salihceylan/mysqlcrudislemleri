import 'package:flutter/material.dart';

class ExpencePlanner extends StatelessWidget {
  ExpencePlanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expence Planner"),
      ),
      body: Container(
        child: Text("Expence Planner"),
      ),
    );
  }
}
