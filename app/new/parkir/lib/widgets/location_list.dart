import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/location.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/location_tile.dart';

import 'custom_text.dart';

class LocationList extends StatelessWidget {
  final List? locations;

  const LocationList({this.locations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> parkings = [];

    if (locations == null) {
      parkings = [LocationTile()];
    } else {
      for (var item in locations!) {
        parkings.add(LocationTile(location: Location(location: item)));
      }
    }
    return Container(
      color: white,
      padding: EdgeInsets.symmetric(vertical: verticalItemPadding),
      child: ListView.separated(
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
