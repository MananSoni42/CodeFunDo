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
  final Widget icon;
  Tip(this.isExpanded, this.header, this.body, this.icon);
}

class _TipsListState extends State<TipsList> {
  final double _appBarHeight = 175.0;
  List<Tip> tips = [
    Tip(
        false,
        'Stuck in an Earthquake ?',
        Text(
            " • Try to take cover under a desk or table\n • If outdoors, get away from buildings and power lines\n • If you are in bed, protect your head with a pillow.\n • If you are in a car, slow down and drive to a clear place",
            softWrap: true, style: TextStyle(fontSize: 15.0)),
        Image(
          image: AssetImage('assets/images/earthquake_symbol.png'),
          width: 50.0,
          height: 50.0,
        )),
    Tip(
        false,
        'Stuck in a Volcano ?',
        Text(
            " • If you live near an active volcano, keep goggles and a mask in an emergency kit, along with a flashlight and a working, battery-operated radio.\n • Evacuate only as recommended by authorities to stay clear of lava, mud flows, and flying rocks and debris.\n • Avoid river areas and low-lying regions.\n • Be aware that ash may put excess weight on your roof and need to be swept away. Wear protection during cleanups.",
            softWrap: true, style: TextStyle(fontSize: 15.0)),
        Image(
            image: AssetImage('assets/images/volcano_symbol.png'),
            width: 50.0,
            height: 50.0)),
    Tip(
        false,
        'Stuck in a Cyclone ?',
        Text(
            " • In case of a storm surge/tide warning, or other flooding, know your nearest safe high ground and the safest access route to it.\n • Put wooden or plastic outdoor furniture in your pool or inside with other loose items.\n • Close shutters or board-up or heavily tape all windows. Draw curtains and lock doors.\n • Wear strong shoes (not thongs) and tough clothing for protection.\n • Lock doors; turn off power, gas, and water; take your evacuation and emergency kits",
            softWrap: true, style: TextStyle(fontSize: 15.0)),
        Image(
          image: AssetImage('assets/images/storm_symbol.png'),
          height: 50.0,
          width: 50.0,
        )),
    Tip(
        false,
        'Stuck in a Tsunami ?',
        Text(
            " • Protect windows with plywood boards\n • Have several days supply of food and water\n • Remain indoors when the eye moves over your area\n • Monitor Weather and Civil Bulletins on NOAA radio\n",
            softWrap: true, style: TextStyle(fontSize: 15.0)),
        Image(
          image: AssetImage('assets/images/tsunami_symbol.png'),
          height: 50.0,
          width: 50.0,
        )),
    Tip(
        false,
        'Stuck in a Flood ?',
        Text(
            " • Seal walls in basements with waterproofing compounds to avoid seepage\n • Be prepared! Pack a bag with important items in case you need to evacuate\n • If there is any possibility of a flash flood, move immediately to higher ground\n • Turn off utilities at the main switches or valves. Disconnect electrical appliances",
            softWrap: true, style: TextStyle(fontSize: 15.0)),
        Image(
          image: AssetImage('assets/images/flood_symbol.png'),
          height: 50.0,
          width: 50.0,
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: _appBarHeight,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(fit: StackFit.expand, children: <Widget>[
                Image(
                  image: AssetImage("assets/images/disasterPic.jpeg"),
                  fit: BoxFit.cover,
                  height: _appBarHeight,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment(0.0, -1.0),
                    end: Alignment(0.0, -0.4),
                    colors: <Color>[Color(0x60000000), Color(0x10000000)],
                  )),
                )
              ])),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      tips[index].isExpanded = !tips[index].isExpanded;
                    });
                  },
                  animationDuration: Duration(milliseconds: 100),
                  children: tips.map((Tip tip) {
                    return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 15.0),
                              child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      tip.isExpanded = !tip.isExpanded;
                                    });
                                  },
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 20.0),
                                  leading: tip.icon,
                                  title: new Text(
                                    tip.header,
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )));
                        },
                        isExpanded: tip.isExpanded,
                        body: Container(
                          child: tip.body,
                          padding: EdgeInsets.all(10.0),
                        ));
                  }).toList(),
                ))
          ],
        ))
      ],
    );
  }
}
