import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/new_tile.dart';
import 'package:parkir/widgets/request_tile.dart';

import 'custom_text.dart';

class NewList extends StatelessWidget {
  const NewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService().getNewLocationsCollection(),
        builder: (_, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List<Widget> Parkings = [];

            final data = snapshot.data!;
            for (var item in data) {
              Parkings.add(NewTile(
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

            Parkings.add(const RequestTile());

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: 'New location for you',
                              weight: FontWeight.bold),
                          const SizedBox(
                            height: 4,
                          ),
                          customText(
                              text: 'Let\' check this location out!',
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
                ),
                verticalItemSpacer(),
                SizedBox(
                  height: 200,
                  width: Get.width,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => Container(
                          padding: EdgeInsets.only(
                              left: index == 0 ? horizontalPadding : 0,
                              right: index == Parkings.length - 1
                                  ? horizontalPadding
                                  : 0),
                          child: Parkings[index]),
                      separatorBuilder: (_, index) =>
                          horizontalItemSpacer(half: true),
                      itemCount: Parkings.length),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
