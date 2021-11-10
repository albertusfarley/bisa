import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkir/constants/colors.dart';

parkingName(
        {required String name,
        required bool verified,
        Color color = dark,
        Color iconColor = Colors.blueAccent,
        double size = 14,
        FontWeight weight = FontWeight.bold}) =>
    RichText(
        text: TextSpan(
            style: GoogleFonts.lexendDeca(
                color: color, fontWeight: weight, fontSize: size),
            children: [
          TextSpan(text: '$name '),
          WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.verified,
                color: iconColor,
                size: size,
              ))
        ]));
