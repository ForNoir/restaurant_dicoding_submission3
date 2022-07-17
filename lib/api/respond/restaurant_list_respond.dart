import 'package:restaurant_dicoding_submission3/model/restaurant.dart';

class RestaurantListRespond {
  bool error;
  String message;
  int count;
  List<Restaurants> restaurants;

  RestaurantListRespond({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListRespond.fromJson(Map<String, dynamic> json) =>
      RestaurantListRespond(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        restaurants: List<Restaurants>.from(
          json['restaurants'].map((x) => Restaurants.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'count': count,
        'restaurans': List<dynamic>.from(restaurants.map((e) => e.toJson())),
      };
}
