import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'aboutUs.dart';
import 'auth_handler.dart';
import 'colors.dart';
import 'disaster_tips.dart';
import 'donateScreen.dart';
import 'map_screen.dart';
import 'scoreCards.dart';
import 'standardScaffold.dart';
import 'tutorialScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:location/location.dart' as location_api;


Future<Null> sendRequest(FirebaseMessaging _firebaseMessaging, String token,
    Map<String, double> currentLocation) async {
  print("Attempting to message");
  var jsonSending = {
    "token": token,
    "latitude": currentLocation["latitude"],
    "longitude": currentLocation["longitude"],
  };
  print("Sending");
  http.post(
    'http://137.117.110.63:5000/score',
    body: json.encode(jsonSending),
    headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
  ).then((response) {
    print('response was ${response.statusCode.toString()}');
    print('app sent : ${response.body.toString()}');
  }).catchError((err) {
    print("ERROR:");
    print(err);
  });
  return null;
}

/* class MessagingTestWidget extends StatelessWidget{
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
 */
final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: secondaryMain,
    primaryColor: primaryMain,
    cardColor: Color(0xFFEEEEEE),
    scaffoldBackgroundColor: Color(0xFFEEEEEE),
    buttonColor: secondaryDark,
    backgroundColor: Color(0xFFEEEEEE),
    textSelectionColor: Colors.lightBlue,
  );
}

void main() {
  runApp(MaterialApp(
      title: 'Catastrofree',
      debugShowCheckedModeBanner: false,
      home: MyAppHome(),
      theme: _kShrineTheme));
}

class MyAppHome extends StatefulWidget {
  final drawerItems = [
    DrawerItem(
        "Safety Score", Icons.developer_board, true, Text("Safety Score")),
    DrawerItem(
        "Donate", Icons.monetization_on, true, Text("Donate for Relief Funds")),
    DrawerItem("I AM UNSAFE !", Icons.directions, true,
        Text("Find Safe Spots Nearby")),
    DrawerItem("Safety Tips", Icons.info, false, null),
    DrawerItem("About", Icons.help, true, Text("About us")),
    DrawerItem("Logout", Icons.account_circle, false, null),
  ];
  @override
  State<StatefulWidget> createState() {
    return _MyAppHomeState();
  }
}

class _MyAppHomeState extends State<MyAppHome> {
  FirebaseMessaging firebaseMessaging;
  static bool loggedIn = false;
  Map<String, double> myLocation = {
    "latitude": 42.0,
    "longitude": 42.0,
  };
  sendCallback(){
  sendRequest(firebaseMessaging, myToken, myLocation);
}
  String myToken;
  int _selectedDrawerIndex = 0;
  int get selectedDrawerIndex => _selectedDrawerIndex;
  set selectedDrawerIndex(int value) {
    _selectedDrawerIndex = value;
    setState(() {
      _selectedDrawerIndex = value;
      Navigator.of(context).pop();
    });
  }

  var myMapWidget = MapWidget();
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return ScoreCardsWidget(sendCallback);
      case 1:
        return DonateWidget();
      case 2:
        return myMapWidget;
      case 3:
        return TipsList();
      case 4:
        return AboutUsWidget();
      case 5:
        signOut() async {
          logout(callback);
          setState(() {
            loggedIn = false;
          });
        }
        signOut();
        return Center(child: CircularProgressIndicator());
      default:
        print("Error");
        return Text("Out of bounds widget!");
    }
  }

  callback(newLoggedIn) {
    try {
      setState(() {
        loggedIn = newLoggedIn;
      });
    } catch (e) {
      print(e);
    }
  }

  alertUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Are you safe?"),
            actions: <Widget>[
              FlatButton(
                child: const Text('YES'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }

  location_api.Location location;
  @override
  void initState() {
    Future<Null> genToken(location_api.Location location) async {
      this.myToken = await firebaseMessaging
          .getToken()
          .timeout(Duration(seconds: 30))
          .catchError((err) {
        print("ERROR GENERATING TOKEN");
        print(err.toString());
      });
      print(myToken);
      Map<String, double> currentLocation = await location.getLocation();
      myLocation = currentLocation;
      location.onLocationChanged().listen((Map<String, double> result) {
        setState(() {
          currentLocation = result;
        });
      });
      sendRequest(firebaseMessaging, myToken, currentLocation);
    }

    location = location_api.Location();
    super.initState();
    checkLoggedIn();
    this.firebaseMessaging = FirebaseMessaging();
    genToken(location);
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
        alertUser();
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
        alertUser();
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
        alertUser();
      },
    );
    firebaseMessaging.requestNotificationPermissions();
    //firebaseMessaging.configure();
  }

  Future<void> checkLoggedIn() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      loggedIn = currentUser != null;
    });
  }

  Tutorial tutorial;
  @override
  Widget build(BuildContext context) {
    tutorial = Tutorial(callback);
    List<Widget> drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var dItem = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(dItem.icon),
        title: Text(dItem.title),
        selected: i == selectedDrawerIndex,
        onTap: () => selectedDrawerIndex = i,
      ));
    }
    drawerOptions.insert(4, Divider());
    if (loggedIn) {
      return StdScaffold(
        showAppBar: widget.drawerItems[_selectedDrawerIndex].appBarEnabled,
        title: widget.drawerItems[_selectedDrawerIndex].appBarTitle,
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            StdUserAccountDrawerHeader(),
            DrawerHeader(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your location\n"),
              Text("Latitude: ${myLocation["latitude"]}"),
              Text("Longitude: ${myLocation["longitude"]}")
            ])),
            Column(
              children: drawerOptions,
            ),
          ],
        )),
      );
    } else {
      return tutorial;
    }
  }
}

class DrawerItem {
  String title;
  IconData icon;
  bool appBarEnabled;
  Text appBarTitle;
  DrawerItem(this.title, this.icon, this.appBarEnabled, this.appBarTitle);
}
