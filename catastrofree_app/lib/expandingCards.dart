import "package:flutter/material.dart";

class ExpCardInfo {
  Widget body1;
  Widget body2;
  bool isExpanded;
  ExpCardInfo({this.body1, this.body2, this.isExpanded});
}

class ExpandableCardWidget extends StatefulWidget {
  ExpandableCardWidget({this.body1, this.body2, Key key}) : super(key: key);
  final Widget body1;
  final Widget body2;
  @override
  State<StatefulWidget> createState() {
    return _ExpandableCardWidget();
  }
}

class _ExpandableCardWidget extends State<ExpandableCardWidget> {
  bool _expanded = false;
  toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  _getChildren(bool expanded) {
    if (expanded) {
      return <Widget>[
        widget.body1,
        Divider(),
        widget.body2,
      ];
    } else {
      return <Widget>[
        widget.body1,
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: _getChildren(_expanded),
        ),
        elevation: 2.0,
        margin: EdgeInsets.all(10.0),
      ),
      onTap: toggle,
    );
  }
}
