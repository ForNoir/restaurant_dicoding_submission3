import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_submission3/database/helper/notification_helper.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/favorite_page_restaurant.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_detail_page.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_home_page.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/setting_page_restaurant.dart';

class HomeTabRestaurant extends StatefulWidget {
  static const routeName = 'restaurant_home_tab';

  const HomeTabRestaurant({Key? key}) : super(key: key);

  @override
  State<HomeTabRestaurant> createState() => _HomeTabRestaurantState();
}

class _HomeTabRestaurantState extends State<HomeTabRestaurant> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Home';
  final NotificationHelper _notificationHelper = NotificationHelper();
  final List<Widget> _listWidget = [
    const RestaurantHomePage(),
    const FavoritePageRestaurant(),
    const SettingPageRestaurant(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: _headlineText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingPageRestaurant.settingsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    // TODO Implement Dispose
    super.dispose();
    selectNotificationSubject.close();
  }
}
