import 'package:flutter/material.dart';
import 'dart:convert';
import 'expandingCards.dart';
import "package:url_launcher/url_launcher.dart";

class DonateWidget extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final String sampleJsonString = """
  [
    {
        "place": "Bihar,India",
        "year": 2017,
        "month": 8,
        "type": "Flood",
        "link": "https://en.wikipedia.org/wiki/2017_Bihar_flood",
        "affected": 514,
        "pay_link": "http://p-y.tm/U7-qLxT",
        "is_enabled": true
    },
    {
        "place": "Gujarat, India",
        "year": 2017,
        "month": 6,
        "type": "Flood",
        "link": "https://en.wikipedia.org/wiki/2017_Gujarat_flood",
        "affected": 224,
        "is_enabled": false
    },
    {
        "place": "Mumbai, India",
        "year": 2017,
        "month": 8,
        "type": "Flood",
        "link": "https://en.wikipedia.org/wiki/2017_Mumbai_flood",
        "affected": 35,
        "is_enabled": false
    },
    {
        "place": "Puebela, Mexico",
        "year": 2017,
        "month": 9,
        "type": "Earthquake",
        "link": "https://en.wikipedia.org/wiki/2017_Puebla_earthquake",
        "affected": 361,
        "is_enabled": false
    },
    {
        "place": "Sulawesi, Indonesia",
        "year": 2018,
        "month": 9,
        "type": "Tsunami",
        "link": "https://en.wikipedia.org/wiki/2018_Sulawesi_earthquake_and_tsunami",
        "affected": 2100,
        "pay_link": "http://p-y.tm/BqQ1-ak",
        "is_enabled": true
    },
    {
        "place": "Japan",
        "year": 2018,
        "month": 7,
        "type": "Flood",
        "link": "https://en.wikipedia.org/wiki/2018_Japan_floods",
        "affected": 225,
        "pay_link": "http://p-y.tm/QQDZ-To",
        "is_enabled": true
    },
    {
        "place": "Kerala, India",
        "year": 2018,
        "month": 8,
        "type": "Flood",
        "link": "https://en.wikipedia.org/wiki/2018_Kerala_floods",
        "affected": 483,
        "pay_link": "http://p-y.tm/Y5Q-1ak",
        "is_enabled": true
    },
    {
        "place": "Sumatra, Indonesia",
        "year": 2018,
        "month": 2,
        "type": "Volcano",
        "link": "https://en.wikipedia.org/wiki/Mount_Sinabung",
        "affected": 50,
        "pay_link": "http://p-y.tm/p9i-1ak",
        "is_enabled": true
    },
    {
        "place": "North India",
        "year": 2018,
        "month": 5,
        "type": "Storm",
        "link": "https://en.wikipedia.org/wiki/2018_Indian_dust_storms",
        "affected": 125,
        "pay_link": "http://p-y.tm/g9f-ghf",
        "is_enabled": true
    },
    {
        "place": "Iraq",
        "year": 2017,
        "month": 11,
        "type": "Earthquake",
        "link": "https://en.wikipedia.org/wiki/2017_Iran%E2%80%93Iraq_earthquake",
        "affected": 630,
        "pay_link": "http://p-y.tm/c-9CoQY",
        "is_enabled": true
    }]
""";

  buildFromJson(sampleJsonString) {
    List<ExpandableCardWidget> cardList = [];
    List sampleJson = jsonDecode(sampleJsonString);
    print("Still building");
    for (var i = 0; i < sampleJson.length; i++) {
      Map campaign = sampleJson[i];
      cardList.add(buildFromMap(campaign));
    }
    return cardList;
  }

  buildFromMap(Map map) {
    int peopleAffected = map['affected'];
    String date = map['month'].toString() + "/" + map['year'].toString();
    FlatButton x;
    if (map["is_enabled"]){
      x = FlatButton(
                child: Text("DONATE"),
                onPressed: () => _launchURL(map["pay_link"]),
              );
    }
    else{
      x = FlatButton(
                child: Text("CLOSED"),
                onPressed: () => null,
              );
    }
    Widget widget1 = Column(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.assessment),
            title: Text(
              map['place'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
                children: [Expanded(child: Text(date)), Text(map["type"])])),
        ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("READ MORE"),
                onPressed: () => _launchURL(map["link"]),
              ),
              x
            ],
          ),
        ),
      ],
    );

    return ExpandableCardWidget(
        body1: widget1,
        body2: Container(
          child: Text(
            "Additional text could be added here like a short story on the disaster",
            softWrap: true,
          ),
          alignment: Alignment.center,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: buildFromJson(sampleJsonString),
    );
  }
}
