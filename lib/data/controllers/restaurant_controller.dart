import 'dart:async';

import 'package:flutter/material.dart';
import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantController extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantController({required this.apiService, required this.id}) {
    listRestaurant();
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> listRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final listRestaurants = await apiService.listRestaurants();
      notifyListeners();
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = listRestaurants.restaurants;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> restaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.restaurantSearch(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantSearch.restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
