import 'package:flutter/material.dart';

import 'scoreWidget.dart';

class ScoreCardsWidget extends StatelessWidget {
  List<Widget> getScoreCards() {
    List<Widget> cards = new List();
    var cardsLength = 4;
    for (var i = 0; i < cardsLength; i++) {
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.report_problem),
            title: Text("Disaster Text Here!!"),
            subtitle: Text("Other Disaster Info"),
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              '''Long long time ago disaster was a very big problem.Then one day it was all sorted by a group of BITS Pilani students who made a brilliant app called Catastrofree. It was an instant hit!. This text is deliberately long so that the developer can check that it is wrapping correctly.''',
              softWrap: true,
            ),
          )
        ],
      )));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = getScoreCards();
    children.insert(0, Container(child: ScoreWidget()));
    Widget centralWidget = ListView(
        children: children);
    return centralWidget;
  }
}
