import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/blueprint/data_restaurant.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> get foods => widget.restaurant.foods;
  List<String> get drinks => widget.restaurant.drinks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Detail Menu',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
                tag: 'restaurant_picture_${widget.restaurant.pictureId}',
                child: Image.network(widget.restaurant.pictureId)),
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
                            widget.restaurant.name,
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
                                widget.restaurant.rating.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(Icons.share_location),
                              Text(widget.restaurant.city),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      textAlign: TextAlign.justify,
                      widget.restaurant.description,
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
                  )
                ],
              ),
            ),
            _ListMenu()
          ],
        ),
      ]),
    );
  }

  Container _ListMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Food Available',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              _ListFood(),
              Text(
                'Drink Available',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              _ListDrink()
            ],
          )
          //  Text('Foods: ${foods.join(", ")}'),
          //       Text('Drinks: ${drinks.join(", ")}'),
        ],
      ),
    );
  }

  SizedBox _ListDrink() {
    return SizedBox(
      height: 150,
      width: double.maxFinite,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/drink.png',
                        height: 100,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            drinks[index],
                            style: GoogleFonts.poppins(fontSize: 15),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 15,
            );
          },
          itemCount: drinks.length),
    );
  }

  SizedBox _ListFood() {
    return SizedBox(
      height: 150,
      width: double.maxFinite,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 15,
          );
        },
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                decoration: const BoxDecoration(color: Colors.white70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/food.jpg',
                      height: 100,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            foods[index],
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: foods.length,
      ),
    );
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
          widget.restaurant.description,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
      ),
    );
  }
}
