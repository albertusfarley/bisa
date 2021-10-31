import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/parking_tile.dart';

import 'custom_text.dart';

class ParkingList extends StatefulWidget {
  const ParkingList({Key? key}) : super(key: key);

  @override
  _ParkingListState createState() => _ParkingListState();
}

class _ParkingListState extends State<ParkingList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService().getLocationsCollection(),
        builder: (_, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data!;

            List<ParkingTile> Parkings = [];

            for (var item in data) {
              Parkings.add(ParkingTile(
                  parking: Parking(
                      name: item['name'],
                      category: item['category'],
                      address: item['address'],
                      call: item['call'],
                      url: item['url'],
                      thumbnail: item['thumbnail'],
                      hours: item['hours'],
                      days: item['days'],
                      coordinates: item['coordinates'])));
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: 'Parking location for you',
                              weight: FontWeight.bold),
                          const SizedBox(height: 4),
                          customText(
                              text: 'Get your space with ease.',
                              color: darkGrey),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(.1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: customText(
                            text: 'See all',
                            color: primary,
                            weight: FontWeight.bold),
                      )
                    ],
                  ),
                  verticalItemSpacer(),
                  for (ParkingTile area in Parkings)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [area, horizontalItemSpacer()],
                    )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
