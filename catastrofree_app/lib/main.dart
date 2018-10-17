import 'package:flutter/material.dart';
import 'scoreCards.dart';

void main() {
  runApp(MaterialApp(
    title: 'Catastrofree',
    home: MyAppHome(),
  ));
}

class MyAppHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Main Screen', style: TextStyle( fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ScoreWidget(),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          ListTile(
            leading: Icon(Icons.developer_board), //(dev) edit this icon
            title: Text('Drawer Title'), //(dev) set this title
            onTap: () {
              //(dev) this should reopen the home screen if not already open
              Navigator.pop(context); // close the drawer - currently closes the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.directions),
            title: Text("Closest Safespots"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text("Fund Local Disasters"),
            onTap: null,
          ),
        ],
        )
      ),
    );
  }
}
