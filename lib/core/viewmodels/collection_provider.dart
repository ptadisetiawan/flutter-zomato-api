import 'package:flutter/material.dart';
import 'package:foodfinder/core/models/collection_model.dart';
import 'package:foodfinder/core/services/collection/collection_services.dart';
import 'package:foodfinder/core/viewmodels/location_provider.dart';
import 'package:foodfinder/core/viewmodels/restaurant_provider.dart';
import 'package:foodfinder/injector.dart';
import 'package:foodfinder/ui/router/router_generator.dart';
import 'package:provider/provider.dart';

class CollectionProvider extends ChangeNotifier {
  /* 
  this is side for proprety data
   */

//* Collection list variable
  List<CollectionModel> _collectionList;
  List<CollectionModel> get collectionList => _collectionList;

  // dependency injection
  CollectionServices collectionServices = locator<CollectionServices>();

  /* 
  funtion field
   */

  // funtion to get all collection in jakarta
  void getAll(BuildContext context) async {
    final locationProv = Provider.of<LocationProvider>(context, listen: false);
    _collectionList = await collectionServices.getAll(
        locationProv.latitude.toString(),
        locationProv.longitude.toString(),
        context);
    notifyListeners();
  }

  // function to navigate to restaurant list by collection
  void goToRestaurantList(
      CollectionModel collection, BuildContext context) async {
    await Provider.of<RestaurantProvider>(context, listen: false)
        .clearRestaurantByCollection();
    Navigator.pushNamed(context, RouterGenerator.routeRestaurantByCollection,
        arguments: collection);
  }
}
