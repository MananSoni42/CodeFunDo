import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";

import 'dart:convert';

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
    }]
""";

  buildFromJson(sampleJsonString) {
    List<Column> cardList = [];
    List sampleJson = jsonDecode(sampleJsonString);
    for (var i = 0; i < sampleJson.length; i++) {
      Map campaign = sampleJson[i];
      cardList.add(buildFromMap(campaign));
    }
    return cardList;
  }

  buildFromMap(Map map) {
    String date = map['month'].toString() + "/" + map['year'].toString();
    OutlineButton donate;
    if (map["is_enabled"]){
      donate = OutlineButton(
                child: Text("DONATE"),
                borderSide: BorderSide(width: .7, color: Colors.black38),
                onPressed: () => _launchURL(map["pay_link"]),
              );
    }
    else{
      donate = OutlineButton(
                child: Text("CLOSED"),
                borderSide: BorderSide(width: .7, color: Colors.black38),
                onPressed: null,
              );
    }
    return Column(
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
              OutlineButton(
                child: Text("READ MORE"),
                borderSide: BorderSide(width: .7, color: Colors.black38),
                onPressed: () => _launchURL(map["link"]),
              ),
              donate
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: buildFromJson(sampleJsonString),
    );
  }
}
