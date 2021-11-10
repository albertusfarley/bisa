import 'package:flutter/material.dart';
import 'package:parkir/widgets/custom_text.dart';

class SeeLocations extends StatelessWidget {
  const SeeLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: customText(text: 'This is see locations screen'),
        ),
      ),
    );
  }
}
