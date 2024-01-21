import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/controllers/database_controller.dart';

import 'package:restaurant_app/widget/search_item.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const routeName = '/favorite_page';
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.red,
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ResultState.hasData) {
            return CustomScrollView(
              semanticChildCount: provider.favorites.length,
              slivers: <Widget>[
                SliverSafeArea(
                    top: false,
                    minimum: const EdgeInsets.only(top: 8),
                    sliver: SliverList(delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < provider.favorites.length) {
                          return SearchItem(
                              restaurant: provider.favorites[index],
                              lastItem: index == provider.favorites.length - 1);
                        }
                        return null;
                      },
                    ))),
              ],
            );
          } else if (provider.state == ResultState.noData) {
            return Center(
              child: Text(provider.message),
            );
          } else if (provider.state == ResultState.error) {
            return const Center(
              child: Text('ERROR PROBLEM'),
            );
          } else {
            return const Center(
              child: Text('ERROR PROBLEM'),
            );
          }
        },
      ),
    );
  }
}
