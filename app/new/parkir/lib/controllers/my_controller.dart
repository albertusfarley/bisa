import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await setPosition();
  }

  var myPosition = Rxn<Map>();

  setPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position result = await Geolocator.getCurrentPosition();
    myPosition.value = {
      'latitude': result.latitude,
      'longitude': result.longitude
    };
  }

  double calculateDistance(
      {required Map myPosition, required Map targetPosition}) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((targetPosition['latitude'] - myPosition['latitude']) * p) / 2 +
        c(myPosition['latitude'] * p) *
            c(targetPosition['latitude'] * p) *
            (1 -
                c((targetPosition['longitude'] - myPosition['longitude']) *
                    p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
}
