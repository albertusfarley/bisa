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
      child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: verticalItemPadding),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => parkings[index],
          separatorBuilder: (context, index) => const SizedBox(
                height: verticalPadding,
              ),
          itemCount: parkings.length),
    );
  }
}
