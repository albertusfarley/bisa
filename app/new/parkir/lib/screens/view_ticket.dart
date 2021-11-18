import 'dart:io';

import 'package:flutter/material.dart';

class ViewTicket extends StatelessWidget {
  final String path;

  const ViewTicket({required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Image.file(File(path)),
        ),
      ),
    );
  }
}
