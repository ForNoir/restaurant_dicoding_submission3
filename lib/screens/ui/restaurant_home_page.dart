import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_provider.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_detail_page.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_search_page.dart';
import 'package:restaurant_dicoding_submission3/screens/widget/card_custom.dart';
import 'package:restaurant_dicoding_submission3/utils/constant.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';

class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({Key? key}) : super(key: key);
  static const routeName = '/restaurants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Restaurant Dip'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RestaurantSearchPage.routeName,
              );
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(), // Loading Widget
                  );
                } else if (state.state == ResultState.error) {
                  // Error Widget
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.wifi_off_rounded,
                          size: 48,
                        ),
                        Text(
                          'Harap periksa internet atau wifi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child:
                        Text('Tidak ada data restaurant \n ${state.messsage}'),
                  );
                } else if (state.state == ResultState.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: state.restaurants.count,
                    itemBuilder: (context, index) {
                      final response = state.restaurants.restaurants[index];
                      return CardCustom(
                        pictureId: smallImageUrl + response.pictureId,
                        name: response.name,
                        city: response.city,
                        rating: response.rating,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            RestaurantDetailPage.routeName,
                            arguments: response,
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Text('Gaada apa-apa disini, coba lagi');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
