import 'package:flutter/material.dart';
import 'package:hello_world/screen/studentDetail.dart';

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student List')),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentDetail("https://i.pravatar.cc/300?img=2")));
              },
              child: Text("Student #2")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentDetail("https://i.pravatar.cc/300?img=10")));
              },
              child: Text("Student #10")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentDetail("https://i.pravatar.cc/300?img=25")));
              },
              child: Text("Student #25"))
        ],
      ),
    );
  }
}
