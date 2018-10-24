import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class AboutUsWidget extends StatelessWidget{
  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
            children: [
              CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 80.0,
              ),
              Container(child : Center(child: Text("Catastrofree",style: TextStyle(fontSize: 30.0),),),padding: EdgeInsets.all(15.0),),
              Center(child: Text("Made for codefundo++ with \u2764", style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),)),
            ],
          ),
          margin: EdgeInsets.all(30.0),
        ), 
        Divider(),
        ListTile(
            onTap:(){ _launchURL("http://github.com/coolsidd");},
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars0.githubusercontent.com/u/8058854?s=460&v=4'),
            ),
            title: Text(
              "Siddharth Singh",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("coolsidd")), 
        Divider(),
        ListTile(
            onTap:(){ _launchURL("http://github.com/MananSoni42");},
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars1.githubusercontent.com/u/31164501?s=460&v=4'),
            ),
            title: Text(
              "Manan Soni",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("MananSoni42")), 
        Divider(),
        ListTile(
            onTap:(){ _launchURL("http://github.com/pro-panda");},
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars0.githubusercontent.com/u/28059150?s=460&v=4'),
            ),
            title: Text(
              "Rahul Bothra",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("pro-panda")), 
        ],
        
      )
    ],);
  }
}