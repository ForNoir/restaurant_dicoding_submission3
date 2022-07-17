import 'package:restaurant_dicoding_submission3/model/restaurant.dart';

class RestaurantListSearch {
  bool error;
  int founded;
  List<Restaurants> restaurants;

  RestaurantListSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantListSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantListSearch(
        error: json['error'],
        founded: json['founded'],
        restaurants: List<Restaurants>.from(
            json['restaurants'].map((x) => Restaurants.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'founded': founded,
        'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
