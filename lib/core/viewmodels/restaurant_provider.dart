import 'package:flutter/material.dart';
import 'package:foodfinder/core/models/restaurant_model.dart';
import 'package:foodfinder/core/models/review_model.dart';
import 'package:foodfinder/core/services/restaurant/restaurant_services.dart';
import 'package:foodfinder/core/services/review/review_services.dart';
import 'package:foodfinder/core/viewmodels/location_provider.dart';
import 'package:foodfinder/injector.dart';
import 'package:foodfinder/ui/router/router_generator.dart';
import 'package:provider/provider.dart';

class RestaurantProvider extends ChangeNotifier {
  /* 
  this is side for property data
   */

  // restaurant list variable
  List<RestaurantModel> _restaurantList;
  List<RestaurantModel> get restaurantList => _restaurantList;

  // restaurant list by specific keyowrd
  List<RestaurantModel> _restaurantByKeywordList;
  List<RestaurantModel> get restaurantByKeywordList => _restaurantByKeywordList;

// restaurant list by collection
  List<RestaurantModel> _restaurantCollectionList;
  List<RestaurantModel> get restaurantCollectionList =>
      _restaurantCollectionList;
  // Review list by restaurant
  List<ReviewModel> _reviewList;
  List<ReviewModel> get reviewLiat => _reviewList;

  // handle event search
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  // dependency injection
  RestaurantServices restaurantServices = locator<RestaurantServices>();
  ReviewServices reviewServices = locator<ReviewServices>();

  /* 
  Function field
   */

  // function to get all restaurant by coordinate
  void getAll(BuildContext context) async {
    final locationProv = Provider.of<LocationProvider>(context, listen: false);
    _restaurantList = await restaurantServices.getAll(
        locationProv.latitude.toString(),
        locationProv.longitude.toString(),
        context);
    notifyListeners();
  }

  void getAllByKeyword(String keyword, BuildContext context) async {
    // set search state to active
    setOnSearch(true);
    // clear previous history
    await clearRestaurantSearch();

    // then fetch new keyword
    final locationProv = Provider.of<LocationProvider>(context, listen: false);
    _restaurantByKeywordList = await restaurantServices.getAllByKeyword(
        keyword,
        locationProv.latitude.toString(),
        locationProv.longitude.toString(),
        context);
    // set search state to deactive
    setOnSearch(false);
    notifyListeners();
  }

  void getAllByCollection(String collectionID, BuildContext context) async {
    _restaurantCollectionList =
        await restaurantServices.getAllByCollection(collectionID, context);
    notifyListeners();
  }

  void getReviewByResID(String restaurantID, BuildContext context) async {
    _reviewList = await reviewServices.getAll(restaurantID, context);
    notifyListeners();
  }

  // function to handle onsearch state
  void setOnSearch(bool status) {
    _onSearch = status;
    notifyListeners();
  }

  // function to clear review
  void clearReview() {
    _reviewList = null;
    notifyListeners();
  }

  // function to clear restaurant list by collection
  void clearRestaurantByCollection() {
    _restaurantCollectionList = null;
    notifyListeners();
  }

  // function to clear restaurant list by keyword
  void clearRestaurantSearch() {
    _restaurantByKeywordList = null;
    notifyListeners();
  }

  // funton to navigate to search restaurant
  void goToSearchRestaurant(BuildContext context) async {
    await clearRestaurantSearch();
    Navigator.pushNamed(context, RouterGenerator.routeRestaurantSearch);
  }
}
