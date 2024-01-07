import 'package:get/get.dart';

import '../api/api_service.dart';
import '../model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantController extends GetxController {
  final ApiService apiService;
  final String id;
  RestaurantController({required this.apiService, required this.id}) {
    fetchRestaurants();
  }
  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;
  Future<dynamic> fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      final listrestaurant = await apiService.listRestaurants();
      _state = ResultState.hasData;
      _restaurantResult = listrestaurant.restaurants;
      return _restaurantResult;
    } catch (e) {
      _state = ResultState.error;
      return _message = ('Error fetching data: $e');
    }
  }
}
