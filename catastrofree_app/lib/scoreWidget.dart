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
  double finalScore = 0.0;
  double dispScore = 0.0;
  Color circleColor = Colors.white;
  Color textColor = Colors.blue;
  AnimationController animation;
  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..addListener(() {
        setState(() {
          dispScore = lerpDouble(0, finalScore, animation.value);
        });
      });
    animation.forward();
    //Tween<double>(begin: 0.0, end: dispScore);
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
    });
    animation.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Your Disaster Score is : ",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                child: Text(
                  dispScore.toString().substring(0, 3),
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 35.0,
                      color: textColor),
                ),
                onTap: updateScore,
              ),
            )
          ],
        ),
      ),
    );
  }
}
