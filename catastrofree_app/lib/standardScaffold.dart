import 'package:flutter/material.dart';

class StdScaffold extends StatefulWidget{
  StdScaffold({Key key, this.title, this.body, this.showAppBar, this.drawer}): super(key: key);
  final Widget body;
  final Drawer drawer;
  final bool showAppBar;
  final Text title;
  @override
  State<StatefulWidget> createState() {
    return _StdScaffold();
  }
}
class _StdScaffold extends State <StdScaffold>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ? AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Navigation menu",
          onPressed: null,
        ),
        title: widget.title,
      ) : null,
      drawer: widget.drawer,
      body: widget.body,
    );
  }
}