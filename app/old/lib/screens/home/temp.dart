import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    final geopoint = Provider.of<DocumentSnapshot>(context);
    final geopointData = geopoint.data();

    for (var k in geopointData.keys) {
      print(k);
      print(geopointData[k].longitude);
      print(geopointData[k].latitude);
    }

    return Container();
  }
}
