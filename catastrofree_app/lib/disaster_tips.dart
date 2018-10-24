import "package:flutter/material.dart";


getTips(){
  return <Widget>[
    Card(child: Column(
      children: [ListTile(
        leading: Icon(Icons.help),
        title: Text('What to do in case of an earthquake?'),
        subtitle: Text("by Dr DooLittle:"),
      ),
      Container(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              '''Long long time ago disaster was a very big problem.Then one day it was all sorted by a group of BITS Pilani students who made a brilliant app called Catastrofree. It was an instant hit!. This text is deliberately long so that the developer can check that it is wrapping correctly.''',
              softWrap: true,
            ),
      )]
    ),) ,
    Card(child: Column(
      children: [ListTile(
        leading: Icon(Icons.help),
        title: Text('What to do in case of an earthquake?'),
        subtitle: Text("by Dr DooLittle:"),
      ),
      Container(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              '''Long long time ago disaster was a very big problem.Then one day it was all sorted by a group of BITS Pilani students who made a brilliant app called Catastrofree. It was an instant hit!. This text is deliberately long so that the developer can check that it is wrapping correctly.''',
              softWrap: true,
            ),
      )]
    ),) 
  ];
}

class DisasterTipWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
            SliverList(delegate: SliverChildListDelegate(),)
          ],
          );
  }
}