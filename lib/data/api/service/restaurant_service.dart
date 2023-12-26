import 'package:restaurant_app/data/api/api_service.dart';

import '../../model/restaurant.dart';

class RestaurantService {
  final apiService = ApiService();

  Future<List<Restaurant>> fetchRestaurants() async {
    final data = await apiService.listRestaurants();
    return List<Restaurant>.from(
        data['restaurant'].map((json) => Restaurant.fromJson(json)));
  }
}
