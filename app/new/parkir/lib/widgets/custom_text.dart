import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parkir/constants/colors.dart';

customText({
  required String text,
  Color color = dark,
  FontWeight weight = FontWeight.normal,
  double size = 14,
  TextAlign alignment = TextAlign.start,
}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      textAlign: alignment,
    );
