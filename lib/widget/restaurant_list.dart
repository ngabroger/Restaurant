import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/detail_page.dart';

import '../data/api/api_service.dart';
import '../data/controllers/restaurant_controller.dart';
import '../data/model/restaurant.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late RestaurantController provider;
    return ChangeNotifierProvider<RestaurantController>(
      create: (_) => RestaurantController(apiService: ApiService(), id: ''),
      child: Consumer<RestaurantController>(builder: (context, state, _) {
        provider = state;
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          final List<Restaurant> restaurant = state.result;
          return _buildList(context, restaurant);
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/offline.png", width: 100),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text("Refresh"),
                onPressed: () {
                  provider.listRestaurant();
                },
              ),
            ],
          ));
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      }),
    );
  }

  Widget _buildList(BuildContext context, List<Restaurant> restaurants) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        Restaurant restaurant = restaurants[index];
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailPage.routeName,
                  arguments: restaurant);
            },
            child: Card(
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            child: Hero(
                              tag: restaurant.pictureId,
                              child: Image(
                                image: NetworkImage(
                                  ApiService.imgUrl + restaurant.pictureId,
                                ),
                                width: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[600],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: GoogleFonts.sourceSerif4(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.restaurant,
                                      size: 25,
                                    ),
                                    SizedBox(width: 7),
                                    Text(restaurant.city),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            // child: Expanded(
                            //   child: Bookmark(
                            //     restaurant: restaurant,
                            //     restaurants: restaurant,
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
