import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widget/restaurant_detail.dart';
import '../data/controllers/detail_restaurant_controller.dart';
import '../data/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;
  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailController provider;
    return ChangeNotifierProvider<DetailController>(
      create: (_) =>
          DetailController(apiService: ApiService(), id: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            restaurant.name,
            style: GoogleFonts.poppins(),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child:
                      Image.network(ApiService.imgUrl + restaurant.pictureId),
                ),
                Consumer<DetailController>(
                  builder: (context, state, _) {
                    provider = state;
                    if (state.state == ResultState.loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == ResultState.hasData) {
                      final restaurant = state.result;
                      return RestaurantDetail(
                          restaurant: restaurant, provider: provider);
                    } else if (state.state == ResultState.noData) {
                      return Center(
                        child: Text('No Data Found'),
                      );
                    } else if (state.state == ResultState.error) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                            'assets/images/offline.png',
                            width: 300,
                            height: 300,
                          ),
                        ],
                      ));
                    } else {
                      return Center(
                        child: Text(
                          'ERROR',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
