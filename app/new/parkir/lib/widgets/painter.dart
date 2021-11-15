import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final paint = Paint();

    Offset a = Offset(size.width * (1 / 4), size.height * (1 / 4));
    Offset b = Offset(size.width * (3 / 4), size.height * (3 / 4));

    Rect slot = Rect.fromPoints(a, b);

    canvas.drawRRect(RRect.fromRectAndRadius(slot, Radius.circular(16)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
