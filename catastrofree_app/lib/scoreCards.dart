import 'package:flutter/material.dart';

import 'scoreWidget.dart';

class ScoreCardsWidget extends StatelessWidget {
  List<Widget> getScoreCards() {
    List<Widget> cards = new List();
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            title: Text("There have been X Y's at this location."),
          ),
        ],
      )));
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            title: Text("There have been X Y's at this location."),
          ),
        ],
      )));
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            title: Text("There have been X Y's at this location."),
          ),
        ],
      )));
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            title: Text("There have been X Y's at this location."),
          ),
        ],
      )));
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
