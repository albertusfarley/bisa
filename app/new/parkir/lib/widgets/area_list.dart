import 'package:flutter/material.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/dummy.dart';
import 'package:parkir/models/parking_area.dart';
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(text: 'Parking Area', weight: FontWeight.bold),
          verticalSpacer(),
          for (ParkingArea parkingArea in buildings)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [AreaTile(area: parkingArea), horizontalSpacer()],
            )
        ],
      ),
    );
  }
}
