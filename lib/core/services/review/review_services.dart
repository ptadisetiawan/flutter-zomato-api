import 'package:flutter/cupertino.dart';
import 'package:foodfinder/core/config/api.dart';
import 'package:foodfinder/core/models/review_model.dart';
import 'package:foodfinder/core/services/base/base_services.dart';

class ReviewServices extends BaseServices {
  Future<List<ReviewModel>> getAll(
      String restaurantID, BuildContext context) async {
    var resp = await request(
        Api.instance.getReview.replaceAll("%res_id%", restaurantID),
        RequestType.GET,
        context,
        useToken: true);

    var reviewList = new List<ReviewModel>();
    // check if response contains restaurant list
    // if (resp.containsKey("restaurants")) {
    resp["user_reviews"].forEach((val) {
      reviewList.add(ReviewModel.fromJson(val["review"]));
    });
    // }
    // print(reviewList.toString());
    return reviewList;
  }
}
