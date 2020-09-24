import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:foodfinder/core/utils/location_utils.dart';
import 'package:foodfinder/injector.dart';

class LocationProvider extends ChangeNotifier {
  /* 
  this is side for property data
   */

  // location address
  String _address;
  String get address => _address;

  // Location coordinate
  double _latitude;
  double get latitude => _latitude;
  double _longitude;
  double get longitude => _longitude;

  // Dependency injection
  LocationUtils locationUtils = locator<LocationUtils>();

  /* 
  funtion field
   */

  // function to load location from GPS and address
  void loadLocation() async {
    await locationUtils.getLocation();

    _address = await locationUtils.getAdress();
    _latitude = locationUtils.latitude;
    _longitude = locationUtils.longitude;
    print(_address);
    notifyListeners();
  }
}
