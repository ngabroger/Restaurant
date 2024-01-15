import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/controllers/detail_restaurant_controller.dart';

class RestaurantDetail extends StatelessWidget {
  final DetailsRestaurant restaurant;
  final DetailController provider;
  const RestaurantDetail(
      {Key? key, required this.restaurant, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: GoogleFonts.sourceSerif4(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber[500],
                                  size: 15,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  restaurant.rating.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.share_location),
                                Text(restaurant.city),
                              ],
                            ),
                            Row(
                              children: [
                                Text(restaurant.address),
                              ],
                            ),
                          ],
                        ),
                      
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        textAlign: TextAlign.justify,
                        restaurant.description,
                        style: GoogleFonts.poppins(fontSize: 15),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          _displayBottomSheet(context);
                        },
                        child: Text(
                          'Read More',
                          style: GoogleFonts.poppins(
                              color: Colors.red[500],
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildFoodImages(restaurant.menus.foods),
                    _buildDrinkImages(restaurant.menus.drinks),
                    SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          Text(
                            'Review Customer',
                            style: GoogleFonts.sourceSerif4(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                              child: ReviewListWidget(
                                  customerReviews: restaurant.customerReviews)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // _ListMenu()
            ],
          ),
        ]);
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        height: 250,
        child: Text(
          restaurant.description,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildFoodImages(List<Category> foods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Food Available',
          style: GoogleFonts.sourceSerif4(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: foods.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              return _buildFoodItem(foods[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFoodItem(Category foodCategory) {
    return Container(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: Image.asset(
              'assets/images/food.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            foodCategory.name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrinkImages(List<Category> drink) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Drink Available',
          style: GoogleFonts.sourceSerif4(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: drink.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              return _buildDrinkItem(drink[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDrinkItem(Category drinkCategory) {
    return Container(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: Image.asset(
              'assets/images/drink.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            drinkCategory.name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewListWidget extends StatelessWidget {
  final List<CustomerReview>
      customerReviews; // Pastikan Anda menyediakan data review

  // Constructor untuk menginisialisasi customerReviews
  const ReviewListWidget({Key? key, required this.customerReviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        CustomerReview review = customerReviews[index];
        return Container(
          width: 200,
          height: 140,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    review.review,
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    review.date,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: customerReviews.length,
    );
  }
}
