import 'package:adventure_eye/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyMap();
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
centerTitle: true,
          title: SafeArea(
            top: true,
            child: Text(
              "Adventure Eye Map",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(33.795769, 72.716983), zoom: 14.0),
          mapType: MapType.normal,
        ),
      ),
    );
  }
}
