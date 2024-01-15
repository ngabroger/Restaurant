import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';
import 'restaurant_detail.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    required this.restaurant,
    required this.lastItem,
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName,
                arguments: restaurant);
          },
          child: Row(
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      ApiService.imgUrl + restaurant.pictureId,
                      fit: BoxFit.cover,
                      width: 76,
                      height: 76,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 2)),
                      Row(children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2)),
                        Text(
                          restaurant.city,
                        ),
                      ]),
                      const Padding(padding: EdgeInsets.only(top: 2)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[800]),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2)),
                          Text(
                            restaurant.rating.toString(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
          ),
        ),
      ],
    );
  }
}
