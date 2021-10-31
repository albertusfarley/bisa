import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/widgets/custom_text.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 150,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customText(
                text: 'Can\'t find your location ?',
                weight: FontWeight.bold,
                alignment: TextAlign.center),
            MaterialButton(
              color: primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
              child: customText(
                  text: 'Request', color: white, weight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
