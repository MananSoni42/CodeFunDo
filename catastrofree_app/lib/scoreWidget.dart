import 'dart:math';
import "dart:ui" show lerpDouble;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatefulWidget {
  @override
  _ScoreWidgetState createState() {
    return _ScoreWidgetState();
  }
}

class _ScoreWidgetState extends State<ScoreWidget>
    with TickerProviderStateMixin {
  static const Map x = {
    0: Color(0xFFd81111),
    1: Color(0xFFd81111),
    2: Color(0xFFf24b4b),
    3: Color(0xFF70e855),
    4: Color(0xFFc68c35),
    5: Color(0xFFe8c555),
    6: Color(0xFFe0e855),
    7: Color(0xFFd1e855),
    8: Color(0xFFb2e855),
    9: Color(0xFF8fe855),
    10: Color(0xFF70e855),
  };
  double finalScore = 0.0;
  static double dispScore = 0.0;
  TextStyle custom_style = TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 70.0,
                            color: x[dispScore.toInt()]);
  Color circleColor = Colors.white;
  Color textColor = Colors.blue;
  AnimationController animation;
  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..addListener(() {
        setState(() {
          dispScore = lerpDouble(0, finalScore, animation.value);
          custom_style = TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 70.0,
                      color: x[dispScore.toInt()]);
        });
      });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void updateScore() {
    setState(() {
      dispScore = 0.0;
      finalScore = Random().nextDouble() * 10;
      custom_style = TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 70.0,
                      color: x[dispScore.toInt()]);
    });
    animation.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 5.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "YOUR RISK INDEX IS",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                border: new Border.all(
                  width: 0.5,
                  color: Color(0xFFC41C00),
                ),
              ),
              child: GestureDetector(
                child: Text(
                  dispScore.toString().substring(0, 3),
                  style: custom_style,
                ),
                onTap: updateScore,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
      ),
    );
  }
}
