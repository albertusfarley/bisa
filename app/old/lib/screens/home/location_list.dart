import 'package:bisa/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bisa/models/loc.dart';
import 'tile.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    List<Loc> locationList = List<Loc>();

    locationList.add(Loc(
        name: 'binus_syahdan',
        displayName: 'Binus Syahdan',
        category: 'University',
        imageURL: 'images/binus_syahdan.jpg'));

    return ListView.builder(
        itemCount: locationList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Tile(locationList[index]);
        });
  }
}
