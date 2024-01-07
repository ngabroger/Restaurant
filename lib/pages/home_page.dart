import 'package:avatar_brick/avatar_brick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import 'package:restaurant_app/widget/bookmark.dart';

import '../data/model/restaurant.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(
              child: Text(
            'Home Page',
            style: GoogleFonts.poppins(fontSize: 20),
          )),
        ),

        // body: Container(
        //   child: _buildList(context),
        // ));
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            _profileAccount(),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.asset(
                  'assets/images/restaurant.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Our Restaurant',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  _listRestaurant(),
                ],
              ),
            )
          ],
        ));
  }

  Container _profileAccount() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: AvatarBrick(
                  image: Image.network(
                    'https://asset.kompas.com/crops/uWy9sjOHu_N21k29z9PxyS63OPg=/0x0:1000x667/1200x800/data/photo/2022/05/04/6271c5c7d49c9.jpg',
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Ujang',
                    style: GoogleFonts.sourceSerif4(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Ayo mulai mencari restaurant hari ini',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.notifications_none,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}

class _listRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(
      init: RestaurantController(apiService: ApiService(), id: ''),
      builder: (controller) {
        if (controller.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.state == ResultState.hasData) {
          final List<Restaurant> restaurants = controller.result;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final individualRestaurant = restaurants[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                        tag:
                                            'restaurant_picture_${individualRestaurant.pictureId}',
                                        child: Image(
                                          image: NetworkImage(
                                            ApiService.imgUrl +
                                                individualRestaurant.pictureId,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                                individualRestaurant.rating
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            individualRestaurant.name,
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
                                              Text(individualRestaurant.city),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: Bookmark(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (controller.state == ResultState.noData) {
          return Center(child: Text(controller.message));
        } else if (controller.state == ResultState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/lost-connection.png", width: 100),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Lost Connection!",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text("Refresh"),
                  onPressed: () {
                    controller.listRestaurant();
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
