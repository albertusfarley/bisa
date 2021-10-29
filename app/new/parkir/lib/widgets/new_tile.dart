import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/location.dart';
import 'package:parkir/widgets/custom_text.dart';

class NewTile extends StatelessWidget {

  final Location location;

  const NewTile({required this.location ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 180,
          width: 140,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  location.thumbnail,
                  fit: BoxFit.cover,
                  height: 180,
                  width: 140,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  height: 32,
                  width: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primary.withOpacity(.9)),
                  child: Center(
                    child: customText(
                        text: 'New', weight: FontWeight.bold, color: white),
                  ),
                ),
              )
            ],
          ),
        );
  }
}
