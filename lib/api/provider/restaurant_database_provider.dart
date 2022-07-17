import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_submission3/database/database_helper.dart';
import 'package:restaurant_dicoding_submission3/model/restaurant.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';

class RestaurantDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantDatabaseProvider({required this.databaseHelper}) {
    getFavorite();
  }

  ResultState? _state;
  ResultState? get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _favorite = [];
  List<Restaurants> get favorite => _favorite;

  void getFavorite() async {
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Belum ada restaurant favorit';
    }
    notifyListeners();
  }

  void addFavorite(Restaurants restaurants) async {
    try {
      await databaseHelper.insertFavorite(restaurants);
      getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Error, coba lagi $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Error, coba lagi $e';
      notifyListeners();
    }
  }
}
