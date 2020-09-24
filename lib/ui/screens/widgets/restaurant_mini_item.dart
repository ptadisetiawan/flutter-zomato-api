import 'package:flutter/material.dart';
import 'package:foodfinder/core/models/restaurant_model.dart';
import 'package:foodfinder/core/viewmodels/restaurant_provider.dart';
import 'package:foodfinder/ui/constant/constant.dart';
import 'package:foodfinder/ui/router/router_generator.dart';
import 'package:foodfinder/ui/screens/widgets/custom_rating.dart';
import 'package:provider/provider.dart';

class RestaurantMiniItem extends StatefulWidget {
  RestaurantModel restaurant;
  RestaurantMiniItem({@required this.restaurant});
  @override
  _RestaurantMiniItemState createState() => _RestaurantMiniItemState();
}

class _RestaurantMiniItemState extends State<RestaurantMiniItem> {
  bool isLongPress = false;
  double marginVertical = 5;
  double marginHorizontal = 0;
  void onLongPress() {
    setState(() {
      isLongPress = true;
      marginVertical = 25;
      marginHorizontal = 25;
    });
  }

  void onLongPressEnd() {
    setState(() {
      marginVertical = 5;
      marginHorizontal = 0;
    });
  }

  void onClick() async {
    await Provider.of<RestaurantProvider>(context, listen: false).clearReview();
    Navigator.pushNamed(context, RouterGenerator.routeDetailRestaurant,
        arguments: widget.restaurant);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      onLongPress: () => onLongPress(),
      onLongPressEnd: (details) => onLongPressEnd(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 10),
        width: deviceWidth(context),
        margin: EdgeInsets.symmetric(
            vertical: marginVertical, horizontal: marginHorizontal),
        child: Column(
          children: [
            Row(
              children: [
                _imageRestaurant(),
                SizedBox(
                  width: 10,
                ),
                _content()
              ],
            ),
            Divider(
              color: Colors.black12,
            )
          ],
        ),
      ),
    );
  }

  Widget _imageRestaurant() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              image: NetworkImage(widget.restaurant.imgUrl),
              fit: BoxFit.cover)),
    );
  }

  Widget _content() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.restaurant.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5,
          ),
          CustomRating(rating: widget.restaurant.ratingStar, useReview: false),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.restaurant.address,
            style: TextStyle(color: Colors.black45),
          )
        ],
      ),
    );
  }
}
