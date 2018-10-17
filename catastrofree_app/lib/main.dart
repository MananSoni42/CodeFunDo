import 'package:flutter/material.dart';
import 'scoreCards.dart';

void main() {
  runApp(MaterialApp(
    title: 'Catastrofree',
    home: MyAppHome(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        accentColor: Colors.amberAccent,
      ),
  ));
}

class MyAppHome extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Statistics", Icons.developer_board),
    new DrawerItem("Safe Spots", Icons.directions),
    new DrawerItem("Donate to tragedies", Icons.monetization_on),
  ];
  @override
  State<StatefulWidget> createState() {
    return _MyAppHomeState();
  }
}

class _MyAppHomeState extends State<MyAppHome> {
  int _selectedDrawerIndex = 0;
  int get selectedDrawerIndex => _selectedDrawerIndex;
  set selectedDrawerIndex(int value){
    setState(() {
          _selectedDrawerIndex = value;
          Navigator.of(context).pop();
        });
  }
  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0: return ScoreWidget();
      case 1: return null;
      case 2: return null;
      default: print("Error");
      return Text("Out of bounds widget!");
    }
  }

  @override
  Widget build(BuildContext context) {
    List <Widget> drawerOptions = <Widget>[];
    for(var i =0; i< widget.drawerItems.length; i++){
      var dItem = widget.drawerItems[i];
      drawerOptions.add(
        ListTile(
          leading: Icon(dItem.icon),
          title: Text(dItem.title),
          selected: i == selectedDrawerIndex,
          onTap: () => selectedDrawerIndex = i,
        )
      );
    }
    return Scaffold(          
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Catastrofree"),
                collapseMode: CollapseMode.parallax,
                background: Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),                  
                ),
              ),
            ),
            _getDrawerItemWidget(_selectedDrawerIndex),
          ],
          ),
          drawer: Drawer(
          child: ListView(
            children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Rahul",style: TextStyle(fontWeight: FontWeight.bold),), 
              accountEmail: null,
              ),
            DrawerHeader(
              child: Text(
                "Score : 1000",
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,),
                ),
            ),
            Column(children: drawerOptions,),
          ],
          )
        ),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title,this.icon);
}