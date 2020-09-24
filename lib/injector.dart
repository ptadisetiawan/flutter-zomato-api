import 'package:foodfinder/core/services/collection/collection_services.dart';
import 'package:foodfinder/core/services/restaurant/restaurant_services.dart';
import 'package:foodfinder/core/services/review/review_services.dart';
import 'package:foodfinder/core/utils/location_utils.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  // register as singleton
  await locator.registerSingleton(CollectionServices());
  await locator.registerSingleton(RestaurantServices());
  await locator.registerSingleton(ReviewServices());
  await locator.registerSingleton(LocationUtils());
}
