import 'package:flutter/cupertino.dart';
import 'package:parkir/constants/colors.dart';

Color color = grey.withOpacity(.2);
double x = 0;
double y = 2;
double blur = y * 2;

BoxShadow myShadow =
    BoxShadow(color: color, offset: Offset(x, y), blurRadius: blur);

List<BoxShadow> listShadow = [myShadow];
