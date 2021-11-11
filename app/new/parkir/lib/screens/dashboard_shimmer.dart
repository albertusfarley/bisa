import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/widgets/custom_shimmer.dart';
import 'package:parkir/widgets/parking_list.dart';
import 'package:parkir/widgets/banner_list.dart';
import 'package:parkir/widgets/new_list.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 16,
                top: 8),
            alignment: Alignment.centerLeft,
            child: CustomShimmer(
              height: 14,
              width: Get.width / 2,
            )),
        NewList(),
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 16),
            alignment: Alignment.centerLeft,
            child: CustomShimmer(
              height: 14,
              width: Get.width / 2,
            )),
        ParkingList()
      ],
    );
  }
}
