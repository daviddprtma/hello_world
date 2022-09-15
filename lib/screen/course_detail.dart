import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  String courses = '';
  String kp = "";
  String hari = "";
  String lokasi = "";
  String sks = "";

  CourseDetail(this.courses, this.kp, this.hari, this.lokasi, this.sks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Course"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(courses),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                color: Colors.white,
                child: Card(
                    child: Text(
                  kp,
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                color: Colors.white,
                child: Card(
                    child: Text(
                  hari,
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                width: 55,
                height: 55,
                margin: EdgeInsets.only(top: 15),
                color: Colors.white,
                child: Card(
                    child: Text(
                  lokasi,
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                color: Colors.white,
                child: Card(
                  child: Text(
                    sks,
                    textAlign: TextAlign.center,
                  ),
                  shadowColor: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
