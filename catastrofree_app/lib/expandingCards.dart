import "package:flutter/material.dart";

class ExpCardInfo {
  Widget body1;
  Widget body2;
  bool isExpanded;
  ExpCardInfo({this.body1,this.body2, this.isExpanded});
}

class ExpandableCardWidget extends StatefulWidget{
  ExpandableCardWidget({this.body1, this.body2,Key key}): super(key: key);
  final Widget body1;
  final Widget body2;
  @override
  State<StatefulWidget> createState() {
    return _ExpandableCardWidget();
  }
}

class _ExpandableCardWidget extends State <ExpandableCardWidget> {
  bool _expanded = false;
  toggle(){
    setState(() {
          _expanded = !_expanded;
        });
    print("Toggled!!");
  }
  _getChildren(bool expanded){
    print("Getting children");
    if(expanded){
      return <Widget>[
        widget.body1,
        Divider(),
        widget.body2,
        IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: toggle,
        ),
      ];
    }
    else {
      return <Widget>[
        widget.body1,
        Divider(),
        IconButton(onPressed: toggle, icon: Icon(Icons.arrow_drop_down),),
      ];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(child: Column(
      children: _getChildren(_expanded),
    ),);
  }
}

