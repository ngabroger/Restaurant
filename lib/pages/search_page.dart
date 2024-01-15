import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widget/search_item.dart';
import '../data/controllers/restaurant_controller.dart';
import 'package:provider/provider.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import '../data/model/restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;
  late RestaurantController _provider;
  late final FocusNode _focusNode;
  List<Restaurant> _restaurant = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 65),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(0, 5)),
              ]),
              alignment: Alignment.center,
              child: AnimationSearchBar(
                  centerTitle: 'Search Restaurant',
                  onChanged: searchData,
                  searchTextEditingController: controller),
            ),
          )),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<RestaurantController>(builder: (context, state, _) {
        _provider = state;
        if (state.state == ResultState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          _restaurant = state.result;
          return _buildItem(_restaurant);
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/offline.png',
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text("Refresh"),
                onPressed: () {
                  _provider.listRestaurant();
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

  Widget _buildItem(results) {
    return ListView.builder(
      itemBuilder: (context, index) => SearchItem(
        restaurant: results[index],
        lastItem: index == results.length - 1,
      ),
      itemCount: results.length,
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _provider = RestaurantController(apiService: ApiService(), id: '');
    controller = TextEditingController();
    init();
  }

  Future init() async {
    final restaurants = await _provider.listRestaurant();

    if (!mounted) {
      return;
    } else {
      setState(() => _restaurant = restaurants);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void searchData(String _query) async {
    final result = await _provider.restaurantSearch(_query);

    if (!mounted) {
      return;
    } else {
      setState(() {
        if (result == String) _restaurant = result;
      });
    }
  }
}
