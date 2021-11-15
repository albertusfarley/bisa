import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/shadow.dart';

import 'package:parkir/models/location.dart';
import 'package:parkir/models/location_name.dart';
import 'package:parkir/screens/location_details.dart';
import 'package:parkir/widgets/custom_shimmer.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/is_open.dart';

class NewTile extends StatelessWidget {
  final Location? parking;

  const NewTile({this.parking, Key? key}) : super(key: key);

  final double tileHeight = 200;
  final double tileWidth = 160;

  @override
  Widget build(BuildContext context) {
    return parking == null
        ? Center(child: CustomShimmer(height: tileHeight, width: tileWidth))
        : Center(
            child: GestureDetector(
              onTap: () => Get.to(() => LocationDetails(id: parking!.id)),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  height: tileHeight,
                  width: tileWidth,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          parking!.thumbnail,
                          fit: BoxFit.cover,
                          height: tileHeight,
                          width: tileWidth,
                        ),
                      ),
                      Container(
                        height: tileHeight,
                        width: tileWidth,
                        padding: const EdgeInsets.all(12),
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  black.withOpacity(.8),
                                  black.withOpacity(0)
                                ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LocationName(raw: parking!.name).widget(
                                color: white, iconColor: white, size: 14),
                            const SizedBox(
                              height: 2,
                            ),
                            IsOpen(hours: parking!.hours, days: parking!.days)
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: Center(
                            child: customText(
                                text: 'New',
                                weight: FontWeight.bold,
                                color: black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
