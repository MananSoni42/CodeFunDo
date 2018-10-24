import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'scoreCards.dart';
import 'standardScaffold.dart';
import 'donateScreen.dart';
import 'map_screen.dart';
import 'aboutUs.dart';
import 'disaster_tips.dart';
import 'colors.dart';
import 'tutorialScreen.dart';

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
    DrawerItem("Disaster Tips", Icons.info, false, null),
    DrawerItem("About", Icons.help, true, Text("About us")),
    DrawerItem("Logout", Icons.account_circle, false, null),
  ];
  @override
  State<StatefulWidget> createState() {
    return _MyAppHomeState();
  }
}

class _MyAppHomeState extends State<MyAppHome> {
  FirebaseMessaging _firebaseMessaging;
  static bool loggedIn = false;
  String myToken;
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
      case 1:
        return DonateWidget();
      case 2:
        return MapWidget();
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
    try{
    setState(() {
      loggedIn = newLoggedIn;
    });
    }catch(e){
      print(e);
    } 
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
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
