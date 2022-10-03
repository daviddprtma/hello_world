import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScore extends StatelessWidget {
  Future<String> topUser() async {
    final prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString("user_id") ?? "";
    return user_id;
  }

  Future<int> topPoint() async {
    final prefs = await SharedPreferences.getInstance();
    int _point = prefs.getInt("_point") ?? 0;
    return _point;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("High Score"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [Text("$topUser")],
          ),
        ));
  }
}
