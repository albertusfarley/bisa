import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/widgets/custom_text.dart';

class IsOpen extends StatefulWidget {
  final Map hours;
  final List days;

  const IsOpen({required this.hours, required this.days, Key? key})
      : super(key: key);

  @override
  _IsOpenState createState() => _IsOpenState();
}

class _IsOpenState extends State<IsOpen> {
  DateTime now = DateTime.now();

  bool isOpen({required DateTime now, required List days, required Map hours}) {
    return (days.contains(now.weekday) &&
        (now.hour >= hours['open'] && now.hour < hours['closed']));
  }

  Text openText() =>
      customText(text: 'Open', weight: FontWeight.bold, color: Colors.green);
  Text closedText() =>
      customText(text: 'Closed', weight: FontWeight.bold, color: Colors.red);

  _getHour() {
    if (mounted) {
      setState(() {
        now = DateTime.now();
      });
    }
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
