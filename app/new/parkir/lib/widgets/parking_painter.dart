import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/coor.dart';
import 'dart:ui' as ui;

class ParkingPainter extends CustomPainter {
  final Map data;
  final Color emptyColor = const Color(0xffeeeef4);
  final Color occupiedColor = const Color(0xff1d88f6);

  ParkingPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Size parkingSize = Size(
        data['size']['width'].toDouble(), data['size']['height'].toDouble());

    drawBuildings(canvas, size, parkingSize, data['buildings']);
    for (var key in data['slots'].keys)
      drawSlot(canvas, size, parkingSize, data['slots'][key]);

    drawText(canvas, size, parkingSize, data['texts']);
  }

  drawBuildings(Canvas canvas, Size size, Size parkingSize, Map buildings) {
    final paint = Paint()..color = light;

    for (String key in buildings.keys) {
      List pts = buildings[key];

      final building = Path();

      building.moveTo(size.width * (pts[0]['x'] / parkingSize.width),
          size.height * (pts[0]['y'] / parkingSize.height));

      for (var i = 1; i < pts.length; i++) {
        building.lineTo(size.width * (pts[i]['x'] / parkingSize.width),
            size.height * (pts[i]['y'] / parkingSize.height));
      }

      building.close();

      canvas.drawPath(building, paint);
      paint
        ..style = PaintingStyle.stroke
        ..color = grey;
      canvas.drawPath(building, paint);
    }
  }

  drawText(Canvas canvas, Size size, Size parkingSize, List texts) {
    for (var textData in texts) {
      TextStyle style = GoogleFonts.lexendDeca(
          color: Color(textData['color']),
          fontSize: textData['size'].toDouble());
      TextSpan text = TextSpan(text: textData['text'], style: style);
      TextPainter textPainter =
          TextPainter(text: text, textDirection: ui.TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(size.width * (textData['x'] / parkingSize.width),
              size.height * (textData['y'] / parkingSize.height)));
    }
  }

  drawSlot(Canvas canvas, Size size, Size parkingSize, Map slot) {
    Paint paint = Paint()..color = slot['empty'] ? emptyColor : occupiedColor;

    int x1 = slot['start'][0];
    int y1 = slot['start'][1];
    int x2 = slot['end'][0];
    int y2 = slot['end'][1];

    Offset a = Offset(size.width * (x1 / parkingSize.width),
        size.height * (y1 / parkingSize.height));
    Offset b = Offset(size.width * (x2 / parkingSize.width),
        size.height * (y2 / parkingSize.height));

    Rect slotRect = Rect.fromPoints(a, b);

    canvas.drawRRect(
        RRect.fromRectAndRadius(slotRect, Radius.circular(0)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
