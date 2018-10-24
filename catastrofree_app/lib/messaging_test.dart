import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<Null> sendRequest(FirebaseMessaging _firebaseMessaging) async{  
  print("Attempting to message");
  String token = await _firebaseMessaging.getToken().timeout(Duration(seconds: 5)).catchError((err){
    print("Error getting token");
    print(err);
    return;
  });
  var jsonSending ={
    "token": token,
    "latitude": "69",
    "longitude": "42",
    "unsafe":"0",
  };
  print("Sending");
  http.post(
    'http://137.117.110.63:5000/token',
    body: json.encode(jsonSending),
    headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
  ).then((response){
    print('response was ${response.statusCode.toString()}');
    print('app sent : ${response.body.toString()}');
  }).catchError((err){
    print("ERROR:");
    print(err);
  });
  return null;
}

class MessagingTestWidget extends StatelessWidget{
  final FirebaseMessaging fcmObj;
  MessagingTestWidget(this.fcmObj);
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Center(
        child: FlatButton(
        child: Text("TEST MESSAGING"),
        onPressed : (){
          sendRequest(this.fcmObj);
          },
      ),)
    ],);
  }
}