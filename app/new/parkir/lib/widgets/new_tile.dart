import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/is_open.dart';

class NewTile extends StatelessWidget {
  final Parking parking;

  const NewTile({required this.parking, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SizedBox(
        height: 200,
        width: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                parking.thumbnail,
                fit: BoxFit.cover,
                height: 200,
                width: 150,
              ),
            ),
            Container(
              height: 200,
              width: 150,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [black.withOpacity(.8), black.withOpacity(0)])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customText(text: parking.name, color: white, size: 14),
                  const SizedBox(
                    height: 2,
                  ),
                  IsOpen(hours: parking.hours, days: parking.days)
                ],
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14), color: primary),
                child: Center(
                  child: customText(
                      text: 'New', weight: FontWeight.bold, color: white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
