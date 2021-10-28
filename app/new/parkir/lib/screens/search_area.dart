import 'package:flutter/material.dart';
import 'package:parkir/widgets/custom_text.dart';

class SearchArea extends StatefulWidget {
  const SearchArea({Key? key}) : super(key: key);

  @override
  _SearchAreaState createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: customText(text: 'Search Area page.'),
        ),
      ),
    );
  }
}
