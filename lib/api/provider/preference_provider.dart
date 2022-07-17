import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_submission3/database/helper/preference_helper.dart';
import 'package:restaurant_dicoding_submission3/utils/theme.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferenceHelper preferenceHelper;

  PreferenceProvider({required this.preferenceHelper}) {
    _getTheme();
    _getDailyRestaurant();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferenceHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRestaurant() async {
    _isDailyRestaurantActive = await preferenceHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferenceHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyRestaurant(bool value) {
    preferenceHelper.setDailyRestaurantActive(value);
    _getDailyRestaurant();
  }
}
