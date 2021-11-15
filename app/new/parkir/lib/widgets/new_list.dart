import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/location.dart';
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
      parkings = [
        horizontalItemSpacer(),
        NewTile(),
        horizontalItemSpacer(),
        NewTile(),
        horizontalItemSpacer()
      ];

      return Container(
          color: white,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: parkings,
              )));
    } else {
      parkings.add(horizontalItemSpacer());
      for (var item in locations!) {
        parkings.add(NewTile(parking: Location(location: item)));
        parkings.add(horizontalItemSpacer());
      }

      parkings.add(const RequestTile());
      parkings.add(horizontalItemSpacer());

      return Container(
        color: white,
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: verticalItemPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: parkings,
          ),
        ),
      );
    }
  }
}
