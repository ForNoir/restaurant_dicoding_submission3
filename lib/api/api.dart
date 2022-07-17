import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:restaurant_dicoding_submission3/api/respond/restaurant_detail_response.dart';
import 'package:restaurant_dicoding_submission3/api/respond/restaurant_list_respond.dart';
import 'package:restaurant_dicoding_submission3/api/respond/restaurant_list_search.dart';

class Api {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const endpointList = 'list';

  // Get List Restaurant
  Future<RestaurantListRespond> getTopHeadlines(http.Client client) async {
    final response = await client.get(Uri.parse(baseUrl + endpointList));
    try {
      if (response.statusCode == 200) {
        return RestaurantListRespond.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal untuk load Top Headlines');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get Search Restaurant
  Future<RestaurantListSearch> getSearch(String query) async {
    final response = await http.get(Uri.parse("${baseUrl}search?q=$query"));
    try {
      if (response.statusCode == 200) {
        return RestaurantListSearch.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal untuk load Search');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get Detail Restaurant
  Future<RestaurantDetailRespond> getDetails(String id) async {
    final response = await http
        .get(Uri.parse('${baseUrl}detail/$id'))
        .timeout((const Duration(seconds: 5)));
    try {
      if (response.statusCode == 200) {
        return RestaurantDetailRespond.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal untuk load hasil search');
      }
    } catch (e) {
      rethrow;
    }
  }
}
