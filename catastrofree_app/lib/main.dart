import 'package:flutter/material.dart';
import 'scoreCards.dart';
import 'standardScaffold.dart';
import 'donateScreen.dart';
import 'map_screen.dart';
import 'aboutUs.dart';
import 'disaster_tips.dart';
import 'colors.dart';
import 'dart:async';
import 'auth_handler.dart';
import 'messaging_test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
    DrawerItem("Statistics", Icons.developer_board, true, Text("Score")),
    DrawerItem(
        "Donate to tragedies", Icons.monetization_on, true, Text("Donate")),
    DrawerItem("Safe Spots", Icons.directions, true, Text("Safe Spots")),
    DrawerItem("Map", Icons.location_on, false, null),
    DrawerItem("Disaster Tips", Icons.info, false, null),
    DrawerItem("About", Icons.help, true, Text("About us")),
    DrawerItem("Account Settings", Icons.account_circle, false, null),
  ];
  @override
  State<StatefulWidget> createState() {
    return _MyAppHomeState();
  }
}

class _MyAppHomeState extends State<MyAppHome> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  UserAccountsDrawerHeader myUserAccountsDrawerHeader = UserAccountsDrawerHeader(
    accountName: Text(
      "Placeholder Text",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    accountEmail: null,
  );

  int _selectedDrawerIndex = 0;
  int get selectedDrawerIndex => _selectedDrawerIndex;
  set selectedDrawerIndex(int value) {
    setState(() {
      _selectedDrawerIndex = value;
      Navigator.of(context).pop();
    });
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return ScoreCardsWidget();
      /* CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Catastrofree"),
                collapseMode: CollapseMode.parallax,
                background: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            ScoreWidget(),
          ],
          );
      case 1:
        return DonateWidget();
      case 2:
        return null;
      case 3:
        return MapWidget();
      case 4:
        return TipsList();
      case 5:
        return AboutUsWidget();
      case 6:
        logout();
        return selectedDrawerIndex = 1;
      default:
        print("Error");
        return Text("Out of bounds widget!");
    }
  }

  @override
  void initState() {
    super.initState();
    this._firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure();
    Future<Null> genToken() async {
      this.myToken = await _firebaseMessaging
          .getToken()
          .timeout(Duration(seconds: 30))
          .catchError((err) {
        print("ERROR GENERATING TOKEN");
        print(err.toString());
      });
      print(myToken);
    }

    genToken();
  }

  @override
  Widget build(BuildContext context) {
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
    return StdScaffold(
      showAppBar: widget.drawerItems[_selectedDrawerIndex].appBarEnabled,
      title: widget.drawerItems[_selectedDrawerIndex].appBarTitle,
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          StdUserAccountDrawerHeader(),
          Column(
            children: drawerOptions,
          ),
        ],
      )),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  bool appBarEnabled;
  Text appBarTitle;
  DrawerItem(this.title, this.icon, this.appBarEnabled, this.appBarTitle);
}
