import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/controllers/my_controller.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/dash_separator.dart';
import 'package:parkir/widgets/distance_text.dart';
import 'package:parkir/widgets/is_open.dart';

class ParkingTile extends StatelessWidget {
  final Parking parking;

  const ParkingTile({required this.parking, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 120.0;
    const double imageHeight = 80.0;
    const double imageWidth = 100.0;

    MyController myController = Get.find();

    print('pos = ${myController.myPosition}');

    return Container(
      height: height,
      width: Get.width,
      // color: Colors.blue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    parking.thumbnail,
                    fit: BoxFit.cover,
                    height: imageHeight,
                    width: imageWidth,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(text: parking.name, weight: FontWeight.bold),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Ionicons.car,
                      color: primary,
                      size: 14,
                    ),
                    customText(text: ' · ', color: darkGrey),
                    // customText(
                    //     text: parking.category, size: 12, color: darkGrey),
                    // customText(text: ' · ', color: darkGrey),
                    customText(
                        text: 'Student, Staff & Public',
                        size: 12,
                        color: darkGrey)
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DashSeparator(
                  color: grey.withOpacity(.5),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    customText(
                        text: 'Parking lot is empty',
                        color: darkGrey,
                        size: 12,
                        weight: FontWeight.bold),
                    customText(text: ' · ', color: darkGrey),
                    Obx(() {
                      Map? myPosition = myController.myPosition.value;

                      print(myPosition);
                      print(parking.coordinates);

                      return myPosition == null
                          ? SizedBox.shrink()
                          : DistanceText(
                              mine: myPosition, target: parking.coordinates);
                    }),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                IsOpen(hours: parking.hours, days: parking.days),
              ],
            ),
          )
        ],
      ),
    );
  }
}
