import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_database_provider.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_detail_page.dart';
import 'package:restaurant_dicoding_submission3/screens/widget/card_custom.dart';
import 'package:restaurant_dicoding_submission3/utils/constant.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';

class FavoritePageRestaurant extends StatelessWidget {
  static const routeName = '/restaurant_favorite_page';

  const FavoritePageRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantDatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              final result = provider.favorite[index];
              return CardCustom(
                pictureId: smallImageUrl + result.pictureId,
                name: result.name,
                city: result.city,
                rating: result.rating,
                onPress: () {
                  Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                      arguments: result);
                },
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Belum ada restaurant favorite',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
