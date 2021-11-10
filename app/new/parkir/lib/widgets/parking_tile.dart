import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/controllers/my_controller.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/screens/parking_details.dart';
import 'package:parkir/widgets/custom_shimmer.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/distance_text.dart';
import 'package:parkir/widgets/is_open.dart';
import 'package:parkir/widgets/parking_name.dart';

class ParkingTile extends StatelessWidget {
  final Parking? parking;

  const ParkingTile({this.parking, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double imageHeight = 80.0;
    const double imageWidth = 80.0;

    MyController myController = Get.find();

    print('pos = ${myController.myPosition}');

    return parking == null
        ? Container(
            height: imageHeight,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                CustomShimmer(height: imageHeight, width: imageWidth),
                const SizedBox(
                  width: horizontalItemPadding,
                ),
                Expanded(
                  child: Container(
                    height: imageHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomShimmer(height: 14, width: Get.width / 3),
                        CustomShimmer(height: 14, width: Get.width / 2),
                        CustomShimmer(height: 14, width: 32)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : GestureDetector(
            onTap: () => Get.to(() => ParkingDetails(id: parking!.id)),
            child: Container(
              height: imageHeight,
              width: Get.width,
              color: white,
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        parking!.thumbnail,
                        fit: BoxFit.cover,
                        height: imageHeight,
                        width: imageWidth,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: horizontalItemPadding,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          parkingName(
                              name: parking!.name, verified: parking!.verified),
                          Row(
                            children: [
                              const Icon(
                                Ionicons.car,
                                color: primary,
                                size: 14,
                              ),
                              customText(text: ' · ', color: darkGrey),
                              customText(
                                  text: parking!.category, color: darkGrey),
                              customText(text: ' · ', color: darkGrey),
                              Obx(() {
                                Map? myPosition = myController.myPosition.value;

                                return myPosition == null
                                    ? SizedBox.shrink()
                                    : DistanceText(
                                        mine: myPosition,
                                        target: parking!.coordinates);
                              }),
                            ],
                          ),
                          IsOpen(hours: parking!.hours, days: parking!.days),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
