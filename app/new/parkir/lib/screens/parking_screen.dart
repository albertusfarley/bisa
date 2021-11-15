import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/location_name.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/painter.dart';

class ParkingScreen extends StatefulWidget {
  final String name;

  const ParkingScreen({required this.name, Key? key}) : super(key: key);

  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocationName(raw: widget.name).widget(size: 16),
      ),
      body: InteractiveViewer(
        child: Center(
          child: Image.network(
              'https://raw.githubusercontent.com/albertusfarley/bisa/main/public/locations/binus_syahdan/assets/parking_lot.png'),
        ),
      ),
      // body: Center(
      //   child: InteractiveViewer(
      //     child: Container(
      //       height: Get.width,
      //       width: Get.width,
      //       color: lightGrey,
      //       child: CustomPaint(
      //         foregroundPainter: Painter(),
      //       ),
      //     ),
      //   ),
      // )
    );
  }
}
