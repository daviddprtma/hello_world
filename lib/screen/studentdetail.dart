import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget {
  String image = "https://i.pravatar.cc/300?img=[imagenumber]";

  StudentDetail(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Detail')),
      body: Image.network(image),
    );
  }
}
