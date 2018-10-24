import "package:flutter/material.dart";

class TipsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TipsListState();
  }
}
class Tip {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon icon;
  Tip(this.isExpanded, this.header, this.body, this.icon);
}

class _TipsListState extends State <TipsList>{
  final double _appBarHeight = 256.0;
  List <Tip> tips = [
    Tip(false, 'Tip#1', Text("Sample Text which is very very very long and wraps (hopefully)",softWrap: true), Icon(Icons.help)),
    Tip(false, 'Tip#1', Text("Sample Text which is very very very long and wraps (hopefully)",softWrap: true), Icon(Icons.help)),
    Tip(false, 'Tip#1', Text("Sample Text which is very very very long and wraps (hopefully)",softWrap: true), Icon(Icons.help)),
    Tip(false, 'Tip#1', Text("Sample Text which is very very very long and wraps (hopefully)",softWrap: true), Icon(Icons.help)),
    
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Disaster tips", softWrap: true,),
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image(
                      image:AssetImage("assets/images/disasterPic.jpeg"),
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                    DecoratedBox(
                      decoration:BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.0, -1.0),
                          end:Alignment(0.0, -0.4),
                          colors: <Color>[Color(0x60000000), Color(0x10000000)],
                        )
                      ),
                    )
                  ]
                )
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(<Widget>[
              Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded){
              setState((){
                tips[index].isExpanded = !tips[index].isExpanded;
              });
            },
            children: tips.map((Tip tip){
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded){
                  return ListTile(
                    leading: tip.icon,
                    title: new Text(
                      tip.header,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    )
                  );
                },
                isExpanded: tip.isExpanded,
                body: Container(child: tip.body,padding: EdgeInsets.all(10.0),)
              );
            }).toList(),
          )
        )
      ],
      )
      )
      ],
    );
    /* ListView(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded){
              setState((){
                tips[index].isExpanded = !tips[index].isExpanded;
              });
            },
            children: tips.map((Tip tip){
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded){
                  return ListTile(
                    leading: tip.icon,
                    title: new Text(
                      tip.header,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    )
                  );
                },
                isExpanded: tip.isExpanded,
                body: tip.body
              );
            }).toList(),
          )
        )
      ],
    ); */
  }
}

// getTips(){
//   return <Widget>[];
//     /* Card(
//       child: Column(
//       children: [ListTile(
//         leading: Icon(Icons.help),
//         title: Text('What to do in case of an earthquake?'),
//         subtitle: Text("by Dr DooLittle:"),
//       ),
//       Container(
//             padding: const EdgeInsets.all(32.0),
//             child: Text(
//               '''Long long time ago disaster was a very big problem.Then one day it was all sorted by a group of BITS Pilani students who made a brilliant app called Catastrofree. It was an instant hit!. This text is deliberately long so that the developer can check that it is wrapping correctly.''',
//               softWrap: true,
//             ),
//       )]
//     ),) ,
//     Card(child: Column(
//       children: [
//         ListTile(
//         leading: Icon(Icons.help),
//         title: Text('What to do in case of an earthquake?'),
//         subtitle: Text("by Dr DooLittle:"),
//       ),
//       Container(
//             padding: const EdgeInsets.all(32.0),
//             child: Text(
//               '''Long long time ago disaster was a very big problem.Then one day it was all sorted by a group of BITS Pilani students who made a brilliant app called Catastrofree. It was an instant hit!. This text is deliberately long so that the developer can check that it is wrapping correctly.''',
//               softWrap: true,
//             ),
//           ),
//         ]
//       ),
//     ) 
//   ]; */
// }

// class DisasterTipWidget extends StatelessWidget{
//   final double _appBarHeight = 256.0;
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               expandedHeight: _appBarHeight,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text("Disaster tips", softWrap: true,),
//                 collapseMode: CollapseMode.parallax,
//                 background: Stack(
//                   fit: StackFit.expand,
//                   children: <Widget>[
//                     Image(
//                       image:AssetImage("assets/images/disasterPic.jpeg"),
//                       fit: BoxFit.cover,
//                       height: _appBarHeight,
//                     ),
//                     DecoratedBox(
//                       decoration:BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment(0.0, -1.0),
//                           end:Alignment(0.0, -0.4),
//                           colors: <Color>[Color(0x60000000), Color(0x10000000)],
//                         )
//                       ),
//                     )
//                   ]
//                 )
//               ),
//             ),
//             SliverList(delegate: SliverChildListDelegate())
//         ],
//     );
//   }
// }