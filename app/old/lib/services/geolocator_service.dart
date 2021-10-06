import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Stream<Position> getCurrentLocation() {
    return getPositionStream(
        desiredAccuracy: LocationAccuracy.high, distanceFilter: 10);
  }

  Future<Position> getInitialLocation() async {
    return getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
