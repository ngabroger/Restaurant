import 'package:get/get.dart';

import '../api/api_service.dart';
import '../model/restaurant.dart';

enum ResultState { loading, hasData, noData, error }

class RestaurantDetail extends GetxController {
  final ApiService apiService;
  final String id;

  RestaurantDetail({required this.apiService, required this.id});

  final Rx<ResultState> _state = ResultState.loading.obs;
  final RxString _message = ''.obs;
  final dynamic _restaurantResult = {}.obs;

  String get message => _message.value;
  dynamic get result => _restaurantResult.value;
  ResultState get state => _state.value;

  Future<void> restaurantDetail(String id) async {
    try {
      _state.value = ResultState.loading;
      final restaurantDetails = await apiService.restaurantDetails(id);
      _state.value = ResultState.hasData;
      _restaurantResult.value = restaurantDetails.restaurant;
    } catch (e) {
      _state.value = ResultState.error;
      _message.value = 'Terdapat Error: $e';
    }
  }
}
