import 'package:bisa/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bisa/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bisa/services/database.dart';

class Gmap extends StatefulWidget {
  final Position initialPosition;

  Gmap(this.initialPosition);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<Gmap> {
  final GeolocatorService geolocatorService = GeolocatorService();
  String _mapStyle;
  GoogleMapController mapController;
  Set<Marker> _markers;
  BitmapDescriptor customIcon;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(80, 80)), 'images/building.png')
        .then((d) => customIcon = d);
  }

  String locationName(String str) {
    List<String> listName = List<String>();
    List<String> listStr = str.split('_');

    for (var s in listStr) {
      s = s[0].toUpperCase() + s.substring(1);
      listName.add(s);
    }
    String name = listName.join(' ');
    return name;
  }

  @override
  Widget build(BuildContext context) {
    Position _userLocation = widget.initialPosition;
    List<Marker> locations = [];

    String key = 'binus_syahdan';

    locations.add(Marker(
        markerId: MarkerId(key),
        position: LatLng(-6.200195, 106.785399),
        icon: customIcon,
        infoWindow: InfoWindow(title: locationName(key))));

    _markers = {};
    _markers.addAll(locations);

    return Center(
      child: GoogleMap(
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _userLocation = widget.initialPosition;
          mapController = controller;
          mapController.setMapStyle(_mapStyle);
          // setState(() {
          //   _markers.addAll(locations);
          // });
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(_userLocation.latitude, _userLocation.longitude),
            zoom: 10.0),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
    );
  }
}
