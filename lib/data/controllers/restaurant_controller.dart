import 'package:get/get.dart';

import '../api/api_service.dart';
import '../model/restaurant.dart';

enum ResultState { loading, hasData, noData, error }

class RestaurantController extends GetxController {
  final ApiService apiService;
  final String id;

  RestaurantController({required this.apiService, required this.id});

  final Rx<ResultState> _state = ResultState.loading.obs;
  final RxList<Restaurant> _result = <Restaurant>[].obs;
  final Rx<String> _message = ''.obs;

  ResultState get state => _state.value;
  RxList<Restaurant> get result => _result;
  String get message => _message.value;

  Future<dynamic> listRestaurant() async {
    try {
      print("Loading...");
      _state.value = ResultState.loading;
      final articleResult = await apiService.listRestaurants();
      final List<Restaurant> data = articleResult.restaurants;
      _state.value = ResultState.hasData;
      _result.addAll(data);
    } catch (e) {
      _state.value = ResultState.error;
      _message.value = 'Error: $e';
    }
  }
}
