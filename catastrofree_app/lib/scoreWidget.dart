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
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..addListener(() {
        setState(() {
          dispScore = lerpDouble(0, finalScore, animation.value);
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
    });
    animation.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "Your Disaster Score",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                child: Text(
                  dispScore.toString().substring(0, 3),
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 50.0,
                      color: textColor),
                ),
                onTap: updateScore,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
