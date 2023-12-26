import 'package:get/get.dart';

import '../api/api_service.dart';
import '../model/restaurant.dart';

class RestaurantController extends GetxController {
  final ApiService apiService = ApiService();
  var restaurants = <Restaurant>[].obs;
  var isLoading = true.obs;

  Future<void> fetchRestaurants() async {
    try {
      isLoading(true);
      final data = await ApiService().listRestaurants();
      if (data.containsKey('restaurants')) {
        restaurants.assignAll((data['restaurants'] as List<dynamic>)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList());
      } else {
        throw Exception("Response doesn't contain 'restaurants' property.");
      }
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }
}
