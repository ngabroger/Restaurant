import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/pages/splash_screen.dart';
import 'data/model/restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
        SearchPage.routeName: (context) => SearchPage()
      },
    );
  }
}
