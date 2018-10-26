import 'package:flutter/material.dart';

import 'scoreWidget.dart';

class ScoreCardsWidget extends StatelessWidget {
  final Function callback;
  ScoreCardsWidget(this.callback);
  List<Widget> getScoreCards() {
    List<Widget> cards = new List();
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:15.0),
            leading: Text("0", style: TextStyle(fontSize:50.0, fontWeight: FontWeight.w200, color: Colors.red)),
            title: Text("Floods ocurred at this location", style: TextStyle(fontSize:19.0, fontWeight: FontWeight.w300)),
          ),
        ],
      )));
      cards.add(
        new Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:15.0),
                leading: Text("0", style: TextStyle(fontSize:50.0, fontWeight: FontWeight.w200, color: Colors.red)),
                title: Text("Earthquakes ocurred at this location", style: TextStyle(fontSize:19.0,fontWeight: FontWeight.w300),),
              ),
            ],
          )
      )
      );
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:15.0),
            leading: Text("0", style: TextStyle(fontSize:50.0, fontWeight: FontWeight.w200, color: Colors.red)),
            title: Text("Storms ocurred in this region", style: TextStyle(fontSize:19.0, fontWeight: FontWeight.w300)),
          ),
        ],
      )));
      cards.add(new Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:15.0),
            leading: Text("0", style: TextStyle(fontSize:50.0, fontWeight: FontWeight.w200, color: Colors.red)),
            title: Text("Tsunamis have hit this area", style: TextStyle(fontSize:19.0, fontWeight: FontWeight.w300)),
          ),
        ],
      )));
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = getScoreCards();
    children.insert(0, Container(child: ScoreWidget(callback)));
    Widget centralWidget = ListView(
        children: children);
    return centralWidget;
  }
}
