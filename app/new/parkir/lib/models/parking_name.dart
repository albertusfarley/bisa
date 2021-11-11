import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkir/constants/colors.dart';

class ParkingName {
  final String raw;
  late bool verified;
  late String text;

  ParkingName({required this.raw}) {
    List nameList = raw.split('\\');
    text = nameList[0];

    verified = nameList.length > 0 && nameList[1] == 'v';
  }

  widget(
      {Color color = dark,
      Color iconColor = Colors.blueAccent,
      double size = 14,
      FontWeight weight = FontWeight.bold,
      bool withVerified = true}) {
    return RichText(
        text: TextSpan(
            style: GoogleFonts.lexendDeca(
                color: color, fontWeight: weight, fontSize: size),
            children: [
          TextSpan(text: '$text '),
          if (withVerified && verified)
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.verified,
                  color: iconColor,
                  size: size,
                ))
        ]));
  }
}
