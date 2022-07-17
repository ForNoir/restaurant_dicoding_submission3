import 'package:restaurant_dicoding_submission3/model/restaurant_detail.dart';

class RestaurantDetailRespond {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailRespond({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailRespond.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailRespond(
        error: json['error'],
        message: json['message'],
        restaurant: Restaurant.fromJsonDetail(json['restaurant']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'restaurant': restaurant.toJson(),
      };
}
