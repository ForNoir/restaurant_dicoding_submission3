import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/api.dart';
import 'package:restaurant_dicoding_submission3/api/provider/preference_provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_database_provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_detail_provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_search_provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/scheduling_provider.dart';
import 'package:restaurant_dicoding_submission3/database/database_helper.dart';
import 'package:restaurant_dicoding_submission3/database/helper/notification_helper.dart';
import 'package:restaurant_dicoding_submission3/database/helper/preference_helper.dart';
import 'package:restaurant_dicoding_submission3/model/restaurant.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/favorite_page_restaurant.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/home_tab_restaurant.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_detail_page.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_search_page.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/setting_page_restaurant.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/splash_screen.dart';
import 'package:restaurant_dicoding_submission3/utils/backgrounds_service.dart';
import 'package:restaurant_dicoding_submission3/utils/navigations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializedIsolate();

  AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Api _api = Api();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(api: _api)),
          ChangeNotifierProvider<RestaurantSearchProvider>(
              create: (_) => RestaurantSearchProvider(api: _api)),
          ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (_) => RestaurantDetailProvider(api: _api)),
          ChangeNotifierProvider<RestaurantDatabaseProvider>(
              create: (_) =>
                  RestaurantDatabaseProvider(databaseHelper: DatabaseHelper())),
          ChangeNotifierProvider<PreferenceProvider>(
              create: (_) => PreferenceProvider(
                  preferenceHelper: PreferenceHelper(
                      sharedPreference: SharedPreferences.getInstance()))),
          ChangeNotifierProvider<SchedulingProvider>(
              create: (_) => SchedulingProvider()),
        ],
        child: Consumer<PreferenceProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Restaurant Dip',
              theme: provider.themeData,
              builder: (context, child) {
                return CupertinoTheme(
                    data: CupertinoThemeData(
                        brightness: provider.isDarkTheme
                            ? Brightness.dark
                            : Brightness.light),
                    child: Material(
                      child: child,
                    ));
              },
              navigatorKey: navigatorKey,
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (context) => const SplashScreen(),
                HomeTabRestaurant.routeName: (context) =>
                    const HomeTabRestaurant(),
                FavoritePageRestaurant.routeName: (context) =>
                    const FavoritePageRestaurant(),
                RestaurantSearchPage.routeName: (context) =>
                    const RestaurantSearchPage(),
                RestaurantDetailPage.routeName: (context) =>
                    RestaurantDetailPage(
                      restaurant: ModalRoute.of(context)?.settings.arguments
                          as Restaurants,
                    ),
                SettingPageRestaurant.routeName: (context) =>
                    const SettingPageRestaurant(),
              },
            );
          },
        ),
      );
}
