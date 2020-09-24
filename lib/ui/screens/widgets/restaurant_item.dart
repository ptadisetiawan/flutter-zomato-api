import 'package:flutter/material.dart';
import 'package:foodfinder/core/models/restaurant_model.dart';
import 'package:foodfinder/core/utils/currency_utils.dart';
import 'package:foodfinder/core/viewmodels/restaurant_provider.dart';
import 'package:foodfinder/ui/constant/constant.dart';
import 'package:foodfinder/ui/router/router_generator.dart';
import 'package:foodfinder/ui/screens/widgets/custom_rating.dart';
import 'package:provider/provider.dart';

class RestaurantItem extends StatefulWidget {
  RestaurantModel restaurant;
  RestaurantItem({@required this.restaurant});
  @override
  _RestaurantItemState createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  bool isLongPress = false;
  double marginVertical = 10;
  double marginHorizontal = 0;
  void onLongPress() {
    setState(() {
      isLongPress = true;
      marginVertical = 25;
      marginHorizontal = 15;
    });
  }

  void onLongPressEnd() {
    setState(() {
      marginVertical = 10;
      marginHorizontal = 0;
    });
  }

  // onclick restaurant item then navigate to restaurant detail
  // but we must clear previous review first
  void onClick() async {
    await Provider.of<RestaurantProvider>(context, listen: false).clearReview();
    Navigator.pushNamed(context, RouterGenerator.routeDetailRestaurant,
        arguments: widget.restaurant);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: deviceWidth(context),
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 9,
                spreadRadius: 1,
                color: Colors.black12.withOpacity(0.1))
          ]),
      child: GestureDetector(
        onTap: () => onClick(),
        onLongPress: () => onLongPress(),
        onLongPressEnd: (details) => onLongPressEnd(),
        child: Column(
          children: [
            _imageCover(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  SizedBox(
                    height: 5,
                  ),
                  CustomRating(
                      rating: widget.restaurant.ratingStar,
                      review: widget.restaurant.review),
                  SizedBox(
                    height: 5,
                  ),
                  _cuisines(),
                  SizedBox(
                    height: 5,
                  ),
                  _price()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
              image: NetworkImage(widget.restaurant.imgUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
    );
  }

  Widget _title() {
    return Text(
      widget.restaurant.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _cuisines() {
    return Text(
      widget.restaurant.cuisines,
      style: TextStyle(color: Colors.black45, fontSize: 12),
    );
  }

  Widget _price() {
    return Text(
      "${widget.restaurant.currency} ${formatter.format(widget.restaurant.priceForTwo)} / 2 person",
      style: TextStyle(
          color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
