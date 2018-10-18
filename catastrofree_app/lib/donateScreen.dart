import 'package:flutter/material.dart';
import 'dart:convert';
import 'expandingCards.dart';

class DonateWidget extends StatelessWidget{
  final String sampleJsonString = """
  [{"affected": 400,
    "place":"Pilani",
    "month":4,
    "year":2013}]
""";

  buildFromJson(sampleJsonString)
  {
    List <ExpandableCardWidget> cardList = [];
    List sampleJson = jsonDecode(sampleJsonString);
    print("Still building");
    for(var i =0; i<sampleJson.length; i++){
      Map campaign = sampleJson[i];
      print(sampleJson[i]["dead"]);
      cardList.add(buildFromMap(campaign));
    }
    return cardList;
  }
  buildFromMap(Map map){
    int peopleAffected = map['affected'];
    String date = map['month'].toString() +"/"+ map['year'].toString();
    Widget widget1 = Column(
      children: <Widget>[
        /* Container(
          child: Text(
            map['place'],
            
            textAlign: TextAlign.left,),
          padding: EdgeInsets.all(10.0)), */
        ListTile(
          leading: Icon(Icons.assessment),
          title: Text(map['place'], style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Row(children:[
          Expanded(child: Text(date)),Text("Type: XXXX")])
        ),    
        ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("READ MORE"),
                onPressed: ()=> null,
              ),
              FlatButton(
                child: Text("DONATE"),
                onPressed: ()=> null,
              )
            ],
          ),
        ), 
      ],
    );
    
    return ExpandableCardWidget(body1: widget1,body2: Container(child : Text("Additional text could be added here like a short story on the disaster", softWrap: true,), alignment: Alignment.center,));
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: buildFromJson(sampleJsonString),
    );
  }
}

