import 'dart:convert';

class RestaurantDetail {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        error: json['error'],
        message: json['message'],
        restaurant: Restaurant.fromJsonDetail(json['restaurant']),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

class Restaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReviews> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJsonDetail(Map<String, dynamic> json) => Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: List<Category>.from(
          json['categories'].map((x) => Category.fromJson(x))),
      menus: Menus.fromJson(json['menus']),
      rating: json['rating'],
      customerReviews: List<CustomerReviews>.from(
          json['customerReviews'].map((x) => CustomerReviews.fromJson(x))));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'city': city,
        'address': address,
        'pictureId': pictureId,
        'categories': List<dynamic>.from(categories.map((x) => x.toJson())),
        'menus': menus.toJson(),
        'rating': rating,
        'customerReviews':
            List<dynamic>.from(customerReviews.map((x) => x.toJson()))
      };
}

class Category {
  String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json['name']);

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

String reviewJson(CustomerReviews reviews) => json.encode(reviews.toJson());

class CustomerReviews {
  late String name;
  late String review;
  late String date;

  CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      CustomerReviews(
          name: json['name'], review: json['review'], date: json['date']);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'review': review,
      'date': date,
    };
  }
}

class Menus {
  late List<Category> foods;
  late List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
      foods:
          List<Category>.from(json['foods'].map((x) => Category.fromJson(x))),
      drinks:
          List<Category>.from(json['drinks'].map((x) => Category.fromJson(x))));

  Map<String, dynamic> toJson() => {
        'foods': List<dynamic>.from(foods.map((x) => x.toJson())),
        'drinks': List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
