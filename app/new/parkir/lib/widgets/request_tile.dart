import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/shadow.dart';
import 'package:parkir/widgets/custom_text.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          width: 160,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // gradient: LinearGradient(
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.topCenter,
              //     colors: [black.withOpacity(.5), white.withOpacity(0)])
              color: white),
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
      ),
    );
  }
}
