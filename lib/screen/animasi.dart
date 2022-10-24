import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

bool animated = false;
late Timer _timer;
double opacityLevel = 0;
int _posisi = 1;
double _left = 0;
double _top = 0;
double _wh = 0;

Widget widget1() {
  return ElevatedButton(
      onPressed: () {},
      child: Text(
        "Click me!",
        style: TextStyle(fontSize: 30),
      ));
}

Widget widget2() {
  return TextButton(
      onPressed: () {},
      child: Text(
        "Click me!",
        style: TextStyle(fontSize: 30),
      ));
}

class Animasi extends StatefulWidget {
  const Animasi({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnimasiState();
  }
}

class _AnimasiState extends State<Animasi> {
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 4000), (timer) {
      setState(() {
        animated = !animated;
        opacityLevel = 1 - opacityLevel;

        _posisi++;
        if (_posisi > 4) _posisi = 1;
        if (_posisi == 1) {
          _left = 300;
          _top = 0;
        }
        if (_posisi == 2) {
          _left = 0;
          _top = 0;
        }
        if (_posisi == 3) {
          _left = 0;
          _top = 200;
        }
        if (_posisi == 4) {
          _left = 300;
          _top = 200;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("animation test"),
        ),
        body: ListView(children: <Widget>[
          //later, we add widgets here
          AnimatedDefaultTextStyle(
            child: Center(child: Text('Hello')),
            style: animated
                ? TextStyle(
                    color: Colors.blue,
                    fontSize: 60,
                  )
                : TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
            duration: Duration(milliseconds: 4000),
          ),
          TextButton(
            child: Text('Animate'),
            onPressed: () {
              setState(() {
                animated = !animated;
              });
            },
          ),
          Container(
              width: 250.0,
              height: 250.0,
              child: AnimatedAlign(
                alignment: animated ? Alignment.topRight : Alignment.bottomLeft,
                duration: const Duration(seconds: 4),
                curve: Curves.fastOutSlowIn,
                child:
                    Image.network('https://placekitten.com/100/100?image=12'),
              )),

          AnimatedOpacity(
            opacity: opacityLevel,
            duration: const Duration(seconds: 4),
            child: Image.network('https://placekitten.com/240/360?image=10'),
          ),

          AnimatedContainer(
            height: animated ? 200 : 300,
            margin: EdgeInsets.all(50),
            decoration: animated
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://placekitten.com/400/400?image=8'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 10,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://placekitten.com/400/400?image=7'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.amber,
                      width: 5,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
            duration: const Duration(seconds: 4),
            curve: Curves.fastOutSlowIn,
          ),

          Center(
              child: AnimatedCrossFade(
            duration: const Duration(seconds: 4),
            firstChild: Image(
                image: AssetImage("assets/images/mark.jpeg"),
                fit: BoxFit.fitWidth,
                width: 200,
                height: 240),
            secondChild: Image(
                image: AssetImage("assets/images/hulk.jpeg"),
                fit: BoxFit.fitWidth,
                width: 200,
                height: 240),
            crossFadeState:
                animated ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          )),

          AnimatedSwitcher(
            duration: const Duration(seconds: 4),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(child: child, turns: animation);
              //return ScaleTransition(child: child, scale: animation);
            },
            child: animated ? widget1() : widget2(),
          ),

          Container(
              width: 400,
              height: 300,
              child: Stack(children: [
                Image.asset(
                  "assets/images/city.jpeg",
                  scale: 0.5,
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 4),
                  curve: Curves.fastOutSlowIn,
                  left: _left,
                  top: _top,
                  child: Image(
                      image: AssetImage("assets/images/ufo.gif"),
                      fit: BoxFit.scaleDown,
                      width: 100,
                      height: 100),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  width: _wh,
                  height: _wh,
                  child: Image.asset("assets/images/ufo.gif"),
                ),
              ])),

          TweenAnimationBuilder(
            duration: const Duration(seconds: 20),
            tween: Tween<double>(begin: 0, end: 5 * math.pi),
            builder: (_, double angle, __) {
              return Transform.rotate(
                angle: angle,
                child: Image.asset('assets/images/earth.png'),
              );
            },
          ),

          TweenAnimationBuilder(
            child: Image.asset('assets/images/earth.png'),
            duration: const Duration(seconds: 10),
            tween: ColorTween(begin: Colors.blue, end: Colors.red),
            builder: (_, Color? color, Widget? child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
                child: child,
              );
            },
          ),
        ]));
  }
}
