import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreference;

  PreferenceHelper({
    required this.sharedPreference,
  });

  static const darkTheme = 'dark_theme';
  static const dailyNews = 'daily_news';

  Future<bool> get isDarkTheme async {
    final preference = await sharedPreference;
    return preference.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final preference = await sharedPreference;
    preference.setBool(darkTheme, value);
  }

  Future<bool> get isDailyRestaurantActive async {
    final preference = await sharedPreference;
    return preference.getBool(dailyNews) ?? false;
  }

  void setDailyRestaurantActive(bool value) async {
    final preference = await sharedPreference;
    preference.setBool(dailyNews, value);
  }
}
