import 'package:flutter/material.dart';
import 'package:hello_world/class/question.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';

late Timer _timer;
int _hitung = 0;
bool _isrun = false;
int _initValue = 30;
var _questions = <QuestionObj>[];
int _question_no = 0;
int _soal_ke = 0;
int _point = 0;
int _round = 0;

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        _hitung--;
        if (_round == _questions[_question_no].picture.length - 1) {
          _round = 0;
          _soal_ke++;
        } else {
          _round++;
        }

        if (_soal_ke == 5) {
          finishAnswer();
          _hitung = _initValue;
        }

        _isrun = true;
      });
    });
  }

  String formatTime(int hitung) {
    var secs = _hitung;
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    _hitung = _initValue;
    startTimer();
    _questions.add(QuestionObj(
        "Not a member of Avenger ",
        [
          'assets/images/hulkhogan.jpg',
        ],
        'Ironman',
        'Spiderman',
        'Thor',
        'Hulk Hogan',
        'Hulk Hogan'));

    _questions.add(QuestionObj(
        "Above the picture who is the actress of Lara Ati? ",
        [
          'assets/images/bayuskak.jpg',
        ],
        'Michael Jackson',
        'Bayu Skak',
        'Nikita Willy',
        'Zoe Jackson',
        'Bayu Skak'));

    _questions.add(QuestionObj(
        "What is the title of the actor in the above is correct from Steven Seagul? ",
        [
          'assets/images/stevenseagal.jpg',
        ],
        'The Expandables',
        'Despicable Me 2',
        'Cars 3',
        'Black Hawk Down',
        'The Expandables'));

    _questions.add(QuestionObj(
        "Which one is the correct title about the picture in the above?",
        [
          'assets/images/minions.jpg',
        ],
        'Fast & Furious 7',
        'Now You See Me',
        'Minions 2',
        'Ghost Buster',
        'Minions 2'));

    _questions.add(QuestionObj(
        "What is the name of the actor in Fast & Furious 7 above in the picture?",
        [
          'assets/images/paulwalker.jpg',
        ],
        'Vin Diesel',
        'Paul Walker',
        'Caleb Walker',
        'Dwayne Johnson',
        'Paul Walker'));

    _questions.add(QuestionObj(
        "When cars 3 get released to the film?",
        [
          'assets/images/cars.jpeg',
        ],
        '2015',
        '2020',
        '2013',
        '2017',
        '2017'));

    _questions.add(QuestionObj(
        "Guess the name of the actor in Rambo 4",
        [
          'assets/images/sylvesterstallone.jpg',
        ],
        'Sylvester Stallone',
        'Steven Seagal',
        'Chuck Norris',
        'Brad Pitt',
        'Sylvester Stallone'));

    _questions.add(QuestionObj(
        "Guess the film title of Brad Pitt which he always shown in the movie",
        [
          'assets/images/bradpitt.jpg',
        ],
        'Athena',
        'World War Z',
        'Lou',
        'Carter',
        'World War Z'));

    _questions.add(QuestionObj(
        "When Turning Red get released above the picture?",
        [
          'assets/images/bradpitt.jpg',
        ],
        '2019',
        '2020',
        '2021',
        '2022',
        '2022'));

    _questions.add(QuestionObj(
        "Who's one actor name whose he/she do filming in Love & Gelato? ",
        [
          'assets/images/loveandgelato.jpg',
        ],
        'Valentina Lodovini',
        'Taylor Swift',
        'Angelina Jolie',
        'Katty Perry',
        'Valentina Lodovini'));

    _questions.shuffle();
    // _questions.add(QuestionObj("Not a member of Teletubbies", 'Dipsy',
    //     'Patrick', 'Laalaa', 'Poo', 'Patrick'));
    // _questions.add(QuestionObj("Not a member of justice league", 'batman',
    //     'superman', 'flash', 'aquades', 'aquades'));
  }

  @override
  void dispose() {
    _timer.cancel();
    _hitung = 0;
    super.dispose();
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        // round 1
        if (_round == 1) {
          _point += 100;
        }
        // round 2
        else if (_round == 2) {
          _point += 75;
        }
        // round 3
        else if (_round == 3) {
          _point += 60;
        }
        // round 4
        else if (_round == 4) {
          _point += 55;
        } else {
          _point += 40;
        }
        _round = 0;
        _soal_ke++;
        _question_no++;
      } else {
        if (_round == _questions[_question_no].picture.length - 1) {
          _round = 0;
          _soal_ke++;
          _question_no++;
        } else {
          _round++;
        }
      }

      if (_soal_ke == 5) {
        finishAnswer();
        _hitung = _initValue;
      }
    });
  }

  finishAnswer() {
    _timer.cancel();
    _question_no = 0;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Quiz'),
              content: Text('Your point = $_point'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Quiz')),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          // CircularPercentIndicator(
          //   radius: 120.0,
          //   lineWidth: 20.0,
          //   percent: 1 - (_hitung / _initValue),
          //   backgroundColor: Colors.amber,
          //   center: Text(
          //     formatTime(_hitung),
          //   ),
          //   progressColor: Colors.red,
          // ),
          LinearPercentIndicator(
            center: Text(
              formatTime(_hitung),
            ),
            width: MediaQuery.of(context).size.width,
            lineHeight: 20.0,
            percent: 1.0 - (_hitung / _initValue),
            backgroundColor: Colors.grey,
            progressColor: Colors.red,
          ),
          Text(_questions[_question_no].narration),
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(_questions[_question_no].picture[_round]),
            ),
          ),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_a);
              },
              child: Text("A. " + _questions[_question_no].option_a)),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_b);
              },
              child: Text("B. " + _questions[_question_no].option_b)),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_c);
              },
              child: Text("C. " + _questions[_question_no].option_c)),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_d);
              },
              child: Text("D. " + _questions[_question_no].option_d)),

          // _isrun == true
          //     ? ElevatedButton(
          //         onPressed: () {
          //           _timer.cancel();
          //           setState(() {
          //             _isrun = false;
          //           });
          //         },
          //         child: Text("Stop"))
          //     : ElevatedButton(
          //         onPressed: () {
          //           startTimer();
          //         },
          //         child: Text("Start"))
        ]))));
  }
}
