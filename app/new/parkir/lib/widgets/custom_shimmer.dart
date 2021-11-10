import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final bool circle;

  const CustomShimmer(
      {required this.height,
      required this.width,
      this.circle = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: white,
              shape: circle ? BoxShape.circle : BoxShape.rectangle),
        ),
        baseColor: lightGrey,
        highlightColor: Colors.grey[100]!);
  }
}
