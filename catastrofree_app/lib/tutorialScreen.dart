import "package:flutter/material.dart";
import 'auth_handler.dart';

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
              LinearProgressIndicator(value: tutorialStage/(totalStages-1),),
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
          floatingActionButton: 
          ListTile(
            trailing: FloatingActionButton(
            child: Text("NEXT"),
            onPressed: () {
              setState(() {
                tutorialStage++;
              });
            },
          ),
        ));
      case 1:
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LinearProgressIndicator(value: tutorialStage/(totalStages-1),),
            ],
          ),
          floatingActionButton: 
          ListTile(
            leading: FloatingActionButton(
            child: Text("BACK"),
            onPressed: () {
              setState(() {
                tutorialStage--;
              });
            },
          ),
            trailing:FloatingActionButton(
            child: Text("LOGIN"),
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
                  tutorialStage = 1;
                });
              }
            },
          ),
             /* FloatingActionButton(
            child: Text("NEXT"),
            onPressed: () {
              setState(() {
                tutorialStage++;
              });
            },
          ), */
        ));
      default:
        return null;
    }
  }
  int tutorialStage = 0;
  final totalStages = 3;
  @override
  Widget build(BuildContext context) {
    return getScreen();
  }
}
