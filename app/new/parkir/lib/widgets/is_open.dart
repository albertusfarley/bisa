import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class IsOpen extends StatefulWidget {
  final Map hours;
  final Map days;

  const IsOpen({required this.hours, required this.days, Key? key})
      : super(key: key);

  @override
  _IsOpenState createState() => _IsOpenState();
}

class _IsOpenState extends State<IsOpen> {
  DateTime now = DateTime.now();

  bool isOpen({required DateTime now, required Map days, required Map hours}) {
    return (now.weekday >= days['start'] && now.weekday <= days['start']) &&
        (now.hour >= hours['open'] && now.hour < hours['closed']);
  }

  RichText openText() => RichText(
          text: const TextSpan(
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              children: [
            WidgetSpan(
                child: Icon(
              Icons.access_time,
              size: 16,
              color: Colors.green,
            )),
            TextSpan(
              text: ' Open',
            )
          ]));
  RichText closedText() => RichText(
          text: const TextSpan(
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              children: [
            WidgetSpan(
                child: Icon(Icons.access_time, size: 16, color: Colors.red)),
            TextSpan(
              text: ' Closed',
            )
          ]));

  _getHour() {
    setState(() {
      now = DateTime.now();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) => _getHour());
  }

  @override
  Widget build(BuildContext context) {
    return isOpen(now: now, hours: widget.hours, days: widget.days)
        ? openText()
        : closedText();
  }
}
