import "package:flutter/material.dart";

import 'auth_handler.dart';
import 'main.dart';

class Tutorial extends StatefulWidget {
  @override
  Tutorial(this.callback);
  State<StatefulWidget> createState() {
    return _TutorialState();
  }

  final Function(bool) callback;
}

class _TutorialState extends State<Tutorial> {
  bool loggedIn = false;
  Widget getScreen() {
    switch (tutorialStage) {
      case 0:
        return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  child: Image(image: AssetImage("assets/images/logo.png")),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 80.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Catastrofree",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  padding: EdgeInsets.all(15.0),
                ),
                Center(
                    child: Text(
                  "Made for codefundo++ with \u2764",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                )),
              ],
            ),
            floatingActionButton: ListTile(
              trailing: OutlineButton(
                shape: RoundedRectangleBorder(),
                child: Text("NEXT"),
                onPressed: () {
                  setState(() {
                    tutorialStage++;
                  });
                },
              ),
            ));
      case 1:
        if (loggedIn) {
          return MyAppHome();
        }
        return Scaffold(
            floatingActionButton: ListTile(
          leading: OutlineButton(
            shape: RoundedRectangleBorder(),
            child: Text("BACK"),
            onPressed: () {
              setState(() {
                tutorialStage--;
              });
            },
          ),
          trailing: OutlineButton(
            child: Text("  NEXT  "),
            shape: RoundedRectangleBorder(),
            onPressed: () {
              setState(() {
                tutorialStage++;
              });
            },
          ),
        ));
      case 2:
        if (loggedIn) {
          return MyAppHome();
        }
        return Scaffold(
            floatingActionButton: ListTile(
              leading: OutlineButton(
                shape: RoundedRectangleBorder(),
                child: Text("BACK"),
                onPressed: () {
                  setState(() {
                    tutorialStage--;
                  });
                },
              ),
              trailing: OutlineButton(
                child: Text("LOGIN"),
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  signIn() async {
                    bool status = await signInWithGoogle();
                    setState(() {
                      loggedIn = status;
                    });
                  }

                  signIn();
                  if (loggedIn) {
                    setState(() {
                      widget.callback(loggedIn);
                    });
                  } else {
                    setState(() {
                      tutorialStage = 2;
                    });
                  }
                },
              ),
            ));
      default:
        tutorialStage = 2;
        return getScreen();
    }
  }

  int tutorialStage = 0;
  @override
  Widget build(BuildContext context) {
    return getScreen();
  }
}
