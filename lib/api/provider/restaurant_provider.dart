import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restaurant_dicoding_submission3/api/api.dart';
import 'package:restaurant_dicoding_submission3/api/respond/restaurant_list_respond.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final Api api;
  RestaurantProvider({
    required this.api,
  }) {
    fetchAllRestaurant();
  }

  String _message = '';
  String get messsage => _message;

  late ResultState _state;
  ResultState get state => _state;

  late RestaurantListRespond _restaurants;
  RestaurantListRespond get restaurants => _restaurants;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await api.getTopHeadlines(Client());
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurant tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurants = restaurant;
      }
    } on TimeoutException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terjadi timeout, mohon coba lagi';
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Tidak ada internet, nyalakan wifi atau internet dan coba lagi';
    } on Error catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
