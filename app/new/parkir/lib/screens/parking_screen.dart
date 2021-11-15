import 'package:flutter/material.dart';
import 'package:parkir/widgets/custom_text.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: customText(text: 'This is parking screen'),
        ),
      ),
    );
  }
}
