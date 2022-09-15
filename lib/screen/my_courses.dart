import 'package:flutter/material.dart';
import 'package:hello_world/screen/course_detail.dart';

class MyCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Course"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Align(alignment: Alignment.center),
          Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/me.jpg")),
                  shape: BoxShape.circle)),
          Container(
            child: Text(
              "David Pratama",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(child: Text("160419103"), margin: EdgeInsets.only(top: 5)),
          Container(
            child: Text("Informatika"),
          ),
          Container(
            child: Text("Gasal 2022-2023"),
          ),
          Container(
            width: 600,
            height: 600,
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail(
                                "Numerical Method",
                                "KP A",
                                "Kamis 10.40",
                                "TF 03.01",
                                "2 sks")));
                  },
                  child: Text("NuMeth (A)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail(
                                "Research Methodology",
                                "KP ZC",
                                "Senin 09.45",
                                "TF 04.02",
                                "3 sks")));
                  },
                  child: Text("RM (ZC)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail("Kerja Praktek",
                                "KP MA", "Senin 19.25", "-", "2 sks")));
                  },
                  child: Text("KP (MA)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail(
                                "Management Information Systems",
                                "KP -",
                                "Selasa 13.00",
                                "TF 02.05",
                                "3 sks")));
                  },
                  child: Text("MIS (-)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail(
                                "Emerging Technology",
                                "KP B",
                                "Senin 07.00",
                                "TC 04C",
                                "3 sks")));
                  },
                  child: Text("EmerTech (B)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail(
                                "Literasi Digital",
                                "KP E5",
                                "Rabu 15.45",
                                "TB 01.01C",
                                "2 sks")));
                  },
                  child: Text("LDI (E5)"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail(
                                "IS Evolving Technology",
                                "KP A",
                                "Kamis 13.00",
                                "TF 02.04",
                                "3 sks")));
                  },
                  child: Text("ISET(A)"),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
