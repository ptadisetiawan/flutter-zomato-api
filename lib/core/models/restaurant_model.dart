class RestaurantModel {
  int id;
  String name;
  String imgUrl;
  String cuisines;
  double ratingStar;
  int review;
  int priceForTwo;
  String address;
  String addressFull;
  String openTime;
  String currency;
  List<String> highlights;

  RestaurantModel(
      {this.id,
      this.name,
      this.imgUrl,
      this.cuisines,
      this.ratingStar,
      this.review,
      this.priceForTwo,
      this.address,
      this.addressFull,
      this.openTime,
      this.highlights,
      this.currency});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    var _highlight = new List<String>();
    json["highlights"].forEach((val) {
      _highlight.add(val);
    });

    return RestaurantModel(
        id: int.parse(json["id"].toString()) ?? 0,
        name: json["name"] ?? "",
        imgUrl: json["featured_image"] ?? "",
        cuisines: json["cuisines"] ?? "",
        ratingStar:
            double.parse(json["user_rating"]["aggregate_rating"].toString()) ??
                "",
        review: int.parse(json["user_rating"]["votes"].toString()) ?? 0,
        priceForTwo: int.parse(json["average_cost_for_two"].toString()) ?? 0,
        address: json["location"]["location_verbose"] ?? "",
        addressFull: json["location"]["address"] ?? "",
        openTime: json["timings"] ?? "",
        highlights: _highlight,
        currency: json["currency"] ?? "");
  }
}
