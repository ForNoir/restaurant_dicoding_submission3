import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_search_provider.dart';
import 'package:restaurant_dicoding_submission3/screens/ui/restaurant_detail_page.dart';
import 'package:restaurant_dicoding_submission3/screens/widget/card_custom.dart';
import 'package:restaurant_dicoding_submission3/utils/constant.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';
import 'package:restaurant_dicoding_submission3/utils/theme.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search_page';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  Widget _listSearch(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          // ignore: sized_box_for_whitespace
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: provider.result?.restaurants.length,
              itemBuilder: (context, index) {
                var response = provider.result!.restaurants[index];
                return CardCustom(
                  pictureId: smallImageUrl + response.pictureId,
                  name: response.name,
                  city: response.city,
                  rating: response.rating,
                  onPress: () {
                    Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                        arguments: response);
                  },
                );
              },
            ),
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Text("Tidak ada data, coba lagi ${provider.message}"),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Column(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 64,
                ),
                Text(
                    "Terjadi error, coba lagi di pencarian \n ${provider.message}"),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Gaada apa-apa di sini'),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cari Restaurant"),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<RestaurantSearchProvider>(
              builder: (context, state, _) {
                return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: secColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: ListTile(
                        leading: const Icon(
                          Icons.search_rounded,
                          size: 28,
                        ),
                        title: TextField(
                          controller: _controller,
                          onChanged: (String value) {
                            if (debounce?.isActive ?? false) {
                              debounce!.cancel();
                            }
                            debounce =
                                Timer(const Duration(milliseconds: 500), () {
                              setState(() {
                                queries = value;
                              });
                              if (value != '') {
                                state.fetchSearchRestaurant(value);
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Cari Restaurant",
                            border: InputBorder.none,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            if (queries != '') {
                              _controller.clear();
                              setState(() {
                                queries = '';
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 28,
                          ),
                        )));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: _listSearch(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
