import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_submission3/api/api.dart';
import 'package:restaurant_dicoding_submission3/api/respond/restaurant_list_search.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final Api api;
  RestaurantSearchProvider({
    required this.api,
  }) {
    fetchSearchRestaurant(query);
  }

  String _query = '';
  String get query => _query;

  String _message = '';
  String get message => _message;

  ResultState? _state;
  ResultState? get state => _state;

  RestaurantListSearch? _restaurantSearchProvider;
  RestaurantListSearch? get result => _restaurantSearchProvider;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      _query = query;
      final restaurantSearch = await api.getSearch(query);

      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurant yang dicari tidak ditemukan.';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchProvider = restaurantSearch;
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
