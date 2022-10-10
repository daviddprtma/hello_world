import 'package:flutter/material.dart';
import 'package:hello_world/screen/quiz.dart';
import 'package:hello_world/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScore extends StatelessWidget {
  // int _point = ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("High Score"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Text("$active_user"),
          ),
        ));
  }
}
