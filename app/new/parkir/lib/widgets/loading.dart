import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.transparent,
      child: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
