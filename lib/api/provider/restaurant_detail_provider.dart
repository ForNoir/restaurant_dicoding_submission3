import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_submission3/api/respond/restaurant_detail_response.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';
import '../api.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final Api api;
  RestaurantDetailProvider({
    required this.api,
  });

  String _message = '';
  String get message => _message;

  ResultState? _state;
  ResultState? get state => _state;

  late RestaurantDetailRespond _restaurantDetailRespond;
  RestaurantDetailRespond get result => _restaurantDetailRespond;

  Future<dynamic> getDetails(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await api.getDetails(id);
      if (restaurants.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data detail restaurant tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailRespond = restaurants;
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
