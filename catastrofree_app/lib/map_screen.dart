import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:flutter/services.dart';
import 'package:map_view/location.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';
import 'package:location/location.dart' as location_api;
import 'dart:async';

const API_KEY = "AIzaSyDwk8miCPs0uLc0IsPPvmg2zMOxZtfTcfg";

class MapWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    MapView.setApiKey(API_KEY);
    return _MapWidgetState();
  }
}

class _MapWidgetState extends State<MapWidget> {
  int height = 450;
  int width = 400;
  List<Polygon> polygons;
  List<Polyline> lines;
  List<Marker> markers;
  String error;
  MapView mapView = MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = StaticMapProvider(API_KEY);
  Uri staticMapUri;
  bool currentWidget = true;
  Map<String, double> startLocation = {
    'latitude': 28.7,
    'longitude': 77.1025,
  };
  Map<String, double> currentLocation;

  StreamSubscription<Map<String, double>> locationSubscription;

  location_api.Location _location = location_api.Location();
  bool permission = false;

  @override
  initState() {
    super.initState();
    initPlatformState();
    locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        currentLocation = result;
      });
    });
    cameraPosition = CameraPosition(
        Location(startLocation["latitude"], startLocation["longitude"]), 2.0);
    staticMapUri = staticMapProvider.getStaticUri(
        Location(startLocation["latitude"], startLocation["longitude"]), 12,
        width: width, height: height, mapType: StaticMapViewType.roadmap);
  }

  initPlatformState() async {
    Map<String, double> location;
    try {
      permission = await _location.hasPermission();
      location = await _location.getLocation();
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please enable it from the app settings';
      }
      location = null;
    }
    if (location != null) {
      setState(() {
        startLocation = location;
      });
    }
  }

  refresh() async {
    width = MediaQuery.of(context).size.width.round();
    height = MediaQuery.of(context).size.height.round();
    cameraPosition = CameraPosition(
        Location(currentLocation["latitude"], currentLocation["longitude"]),
        2.0);
    markers = <Marker>[
      Marker(
        "1",
        "Volcano!",
        28.7, 77.1,
        color: Colors.blue,
        draggable: true, //Allows the user to move the marker.
        markerIcon: MarkerIcon(
          "assets/images/volcano_symbol.png",
          width: 112.0,
          height: 75.0,
        ),
      ),
    ];
    lines = <Polyline>[
      Polyline(
          "11",
          <Location>[
            Location(28.7, 77.1),
            Location(
                currentLocation["latitude"], currentLocation["longitude"]),
          ],
          width: 15.0,
          color: Colors.blue),
    ];
    polygons = <Polygon>[
      Polygon(
          "111",
          <Location>[
            Location(28.7, 77.1),
            Location(
                currentLocation["latitude"], currentLocation["longitude"]),
          ],
          jointType: FigureJointType.bevel,
          strokeWidth: 5.0,
          strokeColor: Colors.red,
          fillColor: Color.fromARGB(75, 255, 0, 0)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            child: ListTile(
          leading: Icon(Icons.warning),
          title: Text("Are you unsafe?"),
          trailing: OutlineButton(
            child: Text("YES"),
            borderSide: BorderSide(width: .7, color: Colors.black38),
            onPressed: null,
          ),
        )),
        Container(
          child: Stack(
            children: <Widget>[
              Center(
                  child: Container(
                child: Text(
                  "You are supposed to see a map here.\n$error",
                  textAlign: TextAlign.center,
                ),
                padding: const EdgeInsets.all(20.0),
              )),
              Container(
                child: Center(
                  child: Image(image: NetworkImage(staticMapUri.toString())),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
