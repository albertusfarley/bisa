import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/screens/see_locations.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/new_tile.dart';
import 'package:parkir/widgets/request_tile.dart';

import 'custom_text.dart';

class NewList extends StatelessWidget {
  final List? locations;

  const NewList({this.locations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> parkings = [];

    if (locations == null) {
      parkings = [NewTile(), NewTile()];

      return Container(
        color: white,
        child: SizedBox(
          height: 200 + (verticalItemPadding * 2),
          width: double.infinity,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? horizontalPadding : 0,
                      right:
                          index == parkings.length - 1 ? horizontalPadding : 0),
                  child: parkings[index]),
              separatorBuilder: (_, index) => horizontalItemSpacer(),
              itemCount: parkings.length),
        ),
      );
    } else {
      for (var item in locations!) {
        parkings.add(NewTile(parking: Parking(parking: item)));
      }

      parkings.add(const RequestTile());

      return Container(
        color: white,
        child: SizedBox(
          height: 200 + (verticalItemPadding * 2),
          width: double.infinity,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? horizontalPadding : 0,
                      right:
                          index == parkings.length - 1 ? horizontalPadding : 0),
                  child: parkings[index]),
              separatorBuilder: (_, index) => horizontalItemSpacer(),
              itemCount: parkings.length),
        ),
      );
    }
  }
}
