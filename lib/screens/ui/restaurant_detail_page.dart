import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_detail_provider.dart';
import 'package:restaurant_dicoding_submission3/model/restaurant.dart';
import 'package:restaurant_dicoding_submission3/model/restaurant_detail.dart';
import 'package:restaurant_dicoding_submission3/screens/widget/favorite_button.dart';
import 'package:restaurant_dicoding_submission3/screens/widget/platform_widget.dart';
import 'package:restaurant_dicoding_submission3/utils/result_state.dart';
import 'package:restaurant_dicoding_submission3/utils/theme.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../utils/constant.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail_page';
  final Restaurants restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      RestaurantDetailProvider provider = Provider.of<RestaurantDetailProvider>(
        context,
        listen: false,
      );
      provider.getDetails(widget.restaurant.id);
    });
    super.initState();
  }

  Widget _buildDetails(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SizedBox(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: '$largeImageUrl${widget.restaurant.pictureId}',
            width: screenWidth,
            fit: BoxFit.cover,
            height: 500,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Stack(children: [
                  SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<RestaurantDetailProvider>(
                            builder: (context, provider, _) {
                              if (provider.state == ResultState.loading) {
                                return const Center(
                                   child: CircularProgressIndicator(),
                                );
                              } else if (provider.state ==
                                  ResultState.hasData) {
                                final response = provider.result.restaurant;
                                final responseFavorite = Restaurants(
                                    id: response.id,
                                    name: response.name,
                                    description: response.description,
                                    pictureId: response.pictureId,
                                    city: response.city,
                                    rating: response.rating);
                                return Stack(children: [
                                  SingleChildScrollView(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(20)),
                                            color: whiteColor),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 28,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        response.name,
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      FavoriteButton(
                                                          favorite:
                                                              responseFavorite),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${response.rating} / 5.0',
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      RatingBar.builder(
                                                          initialRating:
                                                              response.rating,
                                                          allowHalfRating: true,
                                                          ignoreGestures: true,
                                                          minRating: 1,
                                                          maxRating: 5,
                                                          itemCount: 5,
                                                          itemSize: 20,
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                          onRatingUpdate:
                                                              (rating) {})
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 24,
                                                        color: secBlackColor,
                                                      ),
                                                      Text(
                                                        response.city,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(response.description,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 20),
                                                        const Text('Foods',
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        _buildFoodMenu(
                                                            context,
                                                            response
                                                                .menus.foods),
                                                        const Divider(
                                                          height: 12.0,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text('Drinks',
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        _buildDrinkMenu(
                                                            context,
                                                            response
                                                                .menus.drinks),
                                                        const Divider(
                                                          height: 12.0,
                                                          color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      )
                                    ],
                                  ))
                                ]);
                              } else if (provider.state == ResultState.noData) {
                                return const Center(
                                  child: Text('Data tidak ditemukan'),
                                );
                              } else if (provider.state == ResultState.error) {
                                return const Center(
                                  child: Text('Ada yang error'),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )
                        ],
                      ))
                ]),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoodMenu(BuildContext context, List<Category> foods) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(foods[index].name),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDrinkMenu(BuildContext context, List<Category> foods) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(foods[index].name),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return _buildDetails(context);
  }

  Widget _buildIos(BuildContext context) {
    return _buildDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iOSBuilder: _buildIos);
  }
}
