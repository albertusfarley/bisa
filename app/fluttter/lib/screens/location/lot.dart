import 'dart:math';
import 'package:bisa/models/point.dart';
import 'package:bisa/services/database.dart';
import 'package:bisa/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lot extends StatefulWidget {
  final String name;

  Lot({this.name});

  @override
  _LotState createState() => _LotState(name: name);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class _LotState extends State<Lot> {
  final String name;

  _LotState({this.name});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DocumentSnapshot>(context);
    if (data == null) Loading();

    var locationData = data.data()[name];

    double ratio = MediaQuery.of(context).devicePixelRatio;

    int totalSlot = 0;
    int emptySlot = 0;

    Map<String, Map> slots = Map.from(locationData['slot']);
    slots.keys.forEach((areaName) {
      Map area = Map.from(slots[areaName]);
      area.keys.forEach((slotName) {
        Map<String, dynamic> slot = Map.from(area[slotName]);
        bool status = slot['status'];

        if (status) emptySlot++;

        totalSlot++;
      });
    });

    print('Total Slot = ${totalSlot} Empty Slot = ${emptySlot}');

    return Stack(
      children: [
        Container(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(bottom: 32, right: 32),
              child: Text(
                'Empty Slot   ${emptySlot}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        InteractiveViewer(
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: LocationMap(data: locationData, r: ratio),
            ),
          ),
        ),
      ],
    );
  }
}

class LocationMap extends CustomPainter {
  final double r;
  final Map data;
  LocationMap({this.data, this.r});

  Map<String, Map> roofs = Map<String, Map>();
  Map<String, Map> roof = Map<String, Map>();
  Map<String, dynamic> roofPath = Map<String, dynamic>();
  Map<String, int> point = Map<String, int>();
  Map<String, Map> building = Map<String, Map>();

  Color roofColor = Color(0xFFCE714F);
  Color roofShade = Color(0xFFC65D36);

  void drawRoof(Canvas canvas, Map path, String color) {
    var paint = Paint()
      ..color = HexColor(color)
      ..strokeWidth = 1;

    Path roof = Path();
    roof.moveTo(path['1']['x'] / r, path['1']['y'] / r);

    for (var i = 2; i <= path.length; i++) {
      String idx = i.toString();
      roof.lineTo(path[idx]['x'] / r, path[idx]['y'] / r);
    }

    canvas.drawPath(roof, paint);
  }

  void drawSlot(
      Canvas canvas, Point point, double short, int type, bool status) {
    Color empty = Colors.grey[300];
    Color occupied = Colors.blueAccent;

    Paint _paint = Paint()
      ..color = status ? empty : occupied
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    var rect;
    double x = point.x;
    double y = point.y;
    double long = short * 2;

    if (type == 1) rect = Rect.fromLTWH(x / r, y / r, short, long);
    if (type == 2) rect = Rect.fromLTWH(x / r, y / r, long, short);

    canvas.drawRect(rect, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    double short = 5;

    Map<String, Map> buildings = Map.from(data['building']);
    buildings.forEach((buildingIndex, value) {
      Map roof = value['path'];

      roof.forEach((key, roofValue) {
        String color = roofValue['color'];
        drawRoof(canvas, roofValue['path'], color);
      });
    });

    Map<String, Map> slots = Map.from(data['slot']);

    slots.keys.forEach((areaName) {
      Map area = Map.from(slots[areaName]);
      area.keys.forEach((slotName) {
        Map<String, dynamic> slot = Map.from(area[slotName]);

        double x = slot['x'].toDouble();
        double y = slot['y'].toDouble();
        int type = slot['type'];
        bool status = slot['status'];
        Point point = Point(x: x, y: y);

        drawSlot(canvas, point, short, type, status);
      });
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
