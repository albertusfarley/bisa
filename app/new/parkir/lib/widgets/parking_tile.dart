import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/constants/shadow.dart';
import 'package:parkir/controllers/my_controller.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/models/parking_name.dart';
import 'package:parkir/screens/parking_details.dart';
import 'package:parkir/widgets/custom_shimmer.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/distance_text.dart';
import 'package:parkir/widgets/is_open.dart';
import 'package:parkir/widgets/star_bar.dart';

class ParkingTile extends StatelessWidget {
  final Parking? parking;

  const ParkingTile({this.parking, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double imageHeight = 80.0;
    const double imageWidth = 100.0;

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
              height: imageHeight + 12,
              width: Get.width,
              color: white,
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              // alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: double.infinity,
                    width: imageWidth,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: Container(
                            height: imageHeight,
                            width: imageWidth,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: listShadow),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                parking!.thumbnail,
                                fit: BoxFit.fitWidth,
                                height: imageHeight,
                                width: imageWidth,
                              ),
                            ),
                          ),
                        ),
                        if (parking!.rate > 0)
                          Positioned(
                            right: 20,
                            left: 20,
                            bottom: 0,
                            child: Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: white,
                                boxShadow: listShadow,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_rounded,
                                      color: Colors.orange, size: 18),
                                  customText(
                                    text:
                                        ' ' + parking!.rate.toStringAsFixed(1),
                                    weight: FontWeight.bold,
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: horizontalItemPadding + 4,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom:
                              12), // biar rata sama gambar ketika tidak ada rate
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ParkingName(raw: parking!.name).widget(),
                          Row(
                            children: [
                              customText(
                                  text: parking!.category, color: darkGrey),
                              // Obx(() {
                              //   Map? myPosition = myController.myPosition.value;

                              //   return myPosition == null
                              //       ? SizedBox.shrink()
                              //       : DistanceText(
                              //           mine: myPosition,
                              //           target: parking!.coordinates);
                              // }),
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
