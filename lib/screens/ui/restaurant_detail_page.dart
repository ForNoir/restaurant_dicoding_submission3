import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_detail_provider.dart';
import 'package:restaurant_dicoding_submission3/model/restaurant.dart';
import 'package:restaurant_dicoding_submission3/model/restaurant_detail.dart';
import 'package:restaurant_dicoding_submission3/screens/widget/favorite_button.dart';
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
      RestaurantDetailProvider provider = Provider.of(
        context,
        listen: false,
      );
      provider.getDetails(widget.restaurant.id);
    });
    super.initState();
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

  Widget _buildDrinkMenu(BuildContext context, List<Category> drinks) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: drinks.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(drinks[index].name),
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SizedBox(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            width: screenWidth,
            image: '$largeImageUrl${widget.restaurant.pictureId}',
            fit: BoxFit.cover,
            height: 480,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
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
                                  rating: response.rating,
                                );
                                return Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(16),
                                              ),
                                              color: whiteColor,
                                            ),
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        FavoriteButton(
                                                          favorite:
                                                              responseFavorite,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${response.rating} / 5.0',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
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
                                                                  Icon(
                                                            Icons.star,
                                                            color: secColor,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {},
                                                        ),
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
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
                                                        Text(
                                                          response.description,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          const Text(
                                                            'Foods',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          _buildFoodMenu(
                                                              context,
                                                              response
                                                                  .menus.foods),
                                                          Divider(
                                                            height: 12.0,
                                                            color:
                                                                secBlackColor,
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          const Text(
                                                            'Drinks',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          _buildDrinkMenu(
                                                              context,
                                                              response.menus
                                                                  .drinks),
                                                          Divider(
                                                            height: 12.0,
                                                            color:
                                                                secBlackColor,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              } else if (provider.state == ResultState.noData) {
                                return const Center(
                                  child: Text('Tidak ditemukan data'),
                                );
                              } else if (provider.state == ResultState.error) {
                                return const Center(
                                    child: Text('Terjadi error, coba lagi'));
                              } else {
                                return const Center(
                                  child:
                                      Text('Gaada apa-apa disini, coba lagi'),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: mainColor,
                  ),
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
