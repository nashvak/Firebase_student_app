import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService with ChangeNotifier {
  late Position currentPosition;
  String currentAddress = "My Address";
  // A C C E S S   C U R R E N T   L O C A T I O N

  Future<String> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              "Permission for accessing location is denied,Please go to settings and turn on");
      Geolocator.requestPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // print("Longitude:${position.longitude}");
      // print("Latitude:${position.latitude}");
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks[0];

        currentPosition = position;
        currentAddress =
            "${place.locality},${place.postalCode},${place.country}";
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    return currentAddress;
  }
}
