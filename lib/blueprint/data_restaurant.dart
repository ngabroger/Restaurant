import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  final List<String> foods;
  final List<String> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) {
    List<String> foodList = [];
    List<String> drinkList = [];
    for (var food in restaurant['menus']['foods']) {
      foodList.add(food['name']);
    }

    for (var drink in restaurant['menus']['drinks']) {
      drinkList.add(drink['name']);
    }
    return Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: (restaurant['rating'] as num).toDouble(),
        foods: foodList,
        drinks: drinkList);
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null || json.isEmpty) return [];
  final Map<String, dynamic> data = jsonDecode(json);
  if (data.containsKey('restaurants') && data['restaurants'] is List) {
    List<dynamic> restaurantsData = data['restaurants'];
    return restaurantsData.map((json) => Restaurant.fromJson(json)).toList();
  } else {
    return [];
  }
}
