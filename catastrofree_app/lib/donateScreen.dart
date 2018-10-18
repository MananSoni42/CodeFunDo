import 'package:flutter/material.dart';

class Panel {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon icon;
  final Widget score;
  Panel({this.isExpanded, this.header, this.body, this.icon, this.score,});
}

class DonateWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DonateWidgetState();
  }    
}



class _DonateWidgetState extends State <DonateWidget> {
  ExpansionPanel genPanel(Panel panel){
    return ExpansionPanel(headerBuilder: (BuildContext context, bool isExpanded){
      return Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.error),
            title: Text(
              panel.header,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          Container(
            child: panel.score,
            padding: EdgeInsets.all(10.0),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    },
    isExpanded: panel.isExpanded,
    body: panel.body
    );
  }
  List <Panel> panels = [
    Panel(body: Container(child: Text("SomeText regarding the disaster", softWrap: true,),padding: EdgeInsets.all(10.0),),header: "Disaster Title",isExpanded: false,icon: Icon(Icons.healing),score: Text("100"),)
  ];
  ListView panelList;
  

  @override
  Widget build(BuildContext context) {
    panelList = ListView(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded){
              setState((){
                panels[index].isExpanded = !panels[index].isExpanded;
              });
            },
            children: panels.map(genPanel).toList(),

          )
        )
      ],
    );
    return panelList;
  }
}