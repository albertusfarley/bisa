import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

customText(
        {required String text,
        Color color = Colors.black,
        FontWeight weight = FontWeight.normal,
        double size = 14}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
