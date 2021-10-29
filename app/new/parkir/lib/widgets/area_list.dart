import 'package:flutter/material.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/dummy.dart';
import 'package:parkir/models/location.dart';
import 'package:parkir/models/parking_area.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/area_tile.dart';

import 'custom_text.dart';

class AreaList extends StatefulWidget {
  const AreaList({Key? key}) : super(key: key);

  @override
  _AreaListState createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  @override
  Widget build(BuildContext context) {
    List<ParkingArea> buildings = Dummy.kampus;

    return FutureBuilder(
      future: DatabaseService().getLocationsCollection(),
      builder: (_, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData) {
          List data = snapshot.data!;

          List<AreaTile> locations = [];

          for (var item in data) { locations.add(AreaTile(location: Location(name: item['name'], category: item['category'], address: item['address'], call: item['call'], url: item['url'], thumbnail: item['thumbnail'], open: item['open'], closed: item['closed']))); }
              return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(text: 'Parking Area', weight: FontWeight.bold),
          verticalSpacer(),
          for (AreaTile area in locations)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [area, horizontalSpacer()],
            )
        ],
      ),
    );




        } else {
          return Container();
        }
    });

    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 24),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       customText(text: 'Parking Area', weight: FontWeight.bold),
    //       verticalSpacer(),
    //       for (ParkingArea parkingArea in buildings)
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [AreaTile(area: parkingArea), horizontalSpacer()],
    //         )
    //     ],
    //   ),
    // );
  }
}
