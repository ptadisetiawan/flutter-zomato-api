import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodfinder/core/models/collection_model.dart';
import 'package:foodfinder/core/viewmodels/restaurant_provider.dart';
import 'package:foodfinder/ui/screens/widgets/restaurant_item.dart';
import 'package:provider/provider.dart';

class RestaurantByCollectionScreen extends StatelessWidget {
  CollectionModel collection;
  RestaurantByCollectionScreen({@required this.collection});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          collection.title,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: RestaurantByCollectionBody(
        collection: collection,
      ),
    );
  }
}

class RestaurantByCollectionBody extends StatelessWidget {
  CollectionModel collection;
  RestaurantByCollectionBody({@required this.collection});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            _restaurantList()
          ],
        ),
      ),
    );
  }

  Widget _restaurantList() {
    return Builder(
      builder: (context) {
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, child) {
            // if collection data null then fetch
            if (restaurantProv.restaurantCollectionList == null) {
              restaurantProv.getAllByCollection(
                  collection.id.toString(), context);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // if collection is not found
            if (restaurantProv.restaurantCollectionList.length == 0) {
              return Center(
                child: Text("Restoran tidak ditemukan"),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: restaurantProv.restaurantCollectionList.length,
              itemBuilder: (context, index) {
                var restaurant = restaurantProv.restaurantCollectionList[index];
                return RestaurantItem(
                  restaurant: restaurant,
                );
              },
            );
          },
        );
      },
    );
  }
}
