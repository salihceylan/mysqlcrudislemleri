import 'package:flutter/material.dart';
import 'package:mysqlcrudislemleri/components/sol_menu.dart';

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MySQL İşlemleri"), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("Tmm"),
          ),
        ),
      ),
      drawer: SolMenu(),
    );
  }
}
