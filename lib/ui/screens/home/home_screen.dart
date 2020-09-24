import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodfinder/core/viewmodels/collection_provider.dart';
import 'package:foodfinder/core/viewmodels/location_provider.dart';
import 'package:foodfinder/core/viewmodels/restaurant_provider.dart';
import 'package:foodfinder/ui/constant/constant.dart';
import 'package:foodfinder/ui/screens/widgets/collection_item.dart';
import 'package:foodfinder/ui/screens/widgets/restaurant_item.dart';
import 'package:foodfinder/ui/screens/widgets/search_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        title: _appBar(),
      ),
      body: HomeBody(),
    );
  }

  Widget _appBar() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {
            return SearchItem(
              controller: searchController,
              onClick: () => restaurantProv.goToSearchRestaurant(context),
              readOnly: true,
            );
          },
        );
      },
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _locationWidget(),
            SizedBox(height: 10),
            _collectionWidget(),
            SizedBox(height: 10),
            _collectionList(),
            SizedBox(height: 10),
            _restoranList()
          ],
        ),
      ),
    );
  }

  Widget _locationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: primaryColor,
              size: 25,
            ),
            SizedBox(width: 5),
            Consumer<LocationProvider>(
              builder: (context, locationProv, _) {
                // if location address still null
                if (locationProv.address == null) {
                  return Container(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }
                return Expanded(
                  child: Text(
                    locationProv.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              },
            )
          ],
        ),
        Divider(
          color: Colors.black12,
        )
      ],
    );
  }

  Widget _collectionList() {
    return Builder(
      builder: (context) {
        return Consumer2<CollectionProvider, LocationProvider>(
          builder: (context, collectionProv, locationProv, _) {
            // make sure the location is not null
            // because we want to find restaurant by location
            if (locationProv.address == null) {
              locationProv.loadLocation();
              return CircularProgressIndicator();
            }

            // if collection data null then fetch
            if (collectionProv.collectionList == null) {
              collectionProv.getAll(context);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // if collection is not found
            if (collectionProv.collectionList.length == 0) {
              return Center(
                child: Text("Koleksi tidak ditemukan"),
              );
            }

            return Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: collectionProv.collectionList.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var collection = collectionProv.collectionList[index];
                  return CollectionItem(collection: collection);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _collectionWidget() {
    return Text(
      "Koleksi",
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _restoranList() {
    return Builder(builder: (context) {
      return Consumer2<RestaurantProvider, LocationProvider>(
        builder: (context, restaurantProv, locationProv, child) {
          // make sure the location is not null
          // because we want to find restaurant by location
          if (locationProv.address == null) {
            locationProv.loadLocation();
            return CircularProgressIndicator();
          }

          // if collection data null then fecth
          if (restaurantProv.restaurantList == null) {
            restaurantProv.getAll(context);
            return Center(child: CircularProgressIndicator());
          }

          // if collection is not found
          if (restaurantProv.restaurantList.length == 0) {
            return Center(
              child: Text("Restoran tidak ditemukan"),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: restaurantProv.restaurantList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var restaurant = restaurantProv.restaurantList[index];
              return RestaurantItem(
                restaurant: restaurant,
              );
            },
          );
        },
      );
    });
  }
}
