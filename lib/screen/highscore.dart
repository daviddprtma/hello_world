import 'package:flutter/material.dart';
import 'package:hello_world/screen/quiz.dart';
import 'package:hello_world/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _point = 0;

Future<int> checkPoint() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt("_point") ?? 0;
}

Display() {
  checkPoint().then((hasil) {
    if (hasil <= _point) {
      _point = hasil;
    }
  });
}

class HighScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("High Score"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Text("$active_user"),
                Text("Your point is ${Display().toString()}"),
              ],
            ),
          ),
        ));
  }
}
