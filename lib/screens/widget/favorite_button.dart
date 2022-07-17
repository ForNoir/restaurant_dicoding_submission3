import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/restaurant_database_provider.dart';
import 'package:restaurant_dicoding_submission3/model/restaurant.dart';
import 'package:restaurant_dicoding_submission3/utils/theme.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurants favorite;

  const FavoriteButton({Key? key, required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavorited(favorite.id),
            builder: (context, snapshot) {
              var isFavorite = snapshot.data ?? false;
              return isFavorite
                  ? InkWell(
                      onTap: () {
                        provider.removeFavorite(favorite.id);
                        Fluttertoast.showToast(
                          msg: 'Restaurant dihapus dari Favorite',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: secColor,
                          textColor: whiteColor,
                          fontSize: 16.0,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: mainColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.favorite_rounded,
                          color: whiteColor,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        provider.addFavorite(favorite);
                        Fluttertoast.showToast(
                          msg: 'Berhasil menambahkan Restaurant ke Favorite',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: secColor,
                          textColor: whiteColor,
                          fontSize: 16.0,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: mainColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.favorite_outline_rounded,
                          color: whiteColor,
                        ),
                      ),
                    );
            });
      },
    );
  }
}
