import 'package:avatar_brick/avatar_brick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/retry.dart';
import 'package:restaurant_app/blueprint/data_restaurant.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
// import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
// import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import 'package:restaurant_app/widget/bookmark.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantController(apiService: ApiService()));
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
                  SizedBox(
                    width: double.infinity,
                    height: 5000,
                    child: _listRestaurant(),
                  ),
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
  final RestaurantController restaurantController =
      Get.put(RestaurantController(apiService: ApiService()));
  @override
  Widget build(BuildContext context) {
    restaurantController.fetchRestaurants();
    // TODO: implement build
    return Obx(() {
      if (restaurantController.state == ResultState.loading) {
        return CircularProgressIndicator();
      } else if (restaurantController.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: restaurantController.result.length,
          itemBuilder: (context, index) {
            Restaurant restaurant = restaurantController.result[index];
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(restaurant.name),
                subtitle: Text(restaurant.description),
              ),
            );
          },
        );
      } else if (restaurantController.state == ResultState.error) {
        return Text('error ${restaurantController.message}');
      } else {
        return Text('Error');
      }
    });
  }
}
