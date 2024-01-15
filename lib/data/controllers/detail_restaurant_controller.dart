import 'dart:async';

import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../model/restaurant_review.dart';

enum ResultState { loading, noData, hasData, error }

class DetailController extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailController({required this.apiService, required this.id}) {
    restaurantDetail(id);
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  dynamic get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> restaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetails = await apiService.restaurantDetails(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantDetails.detailsRestaurant;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error bang $e';
    }
  }
}
