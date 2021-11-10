import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/parking_tile.dart';

import 'custom_text.dart';

class ParkingList extends StatelessWidget {
  final List? locations;

  const ParkingList({this.locations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> parkings = [];

    if (locations == null) {
      parkings = [ParkingTile()];
    } else {
      for (var item in locations!) {
        parkings.add(ParkingTile(parking: Parking(parking: item)));
      }
    }
    return Container(
      color: white,
      padding: EdgeInsets.symmetric(vertical: verticalItemPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (Widget area in parkings)
            Padding(
              padding: const EdgeInsets.only(bottom: horizontalPadding),
              child: area,
            )
        ],
      ),
    );
  }
}
