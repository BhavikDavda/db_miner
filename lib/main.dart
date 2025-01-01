
import 'package:db_miner/view/screens/detailpage.dart';
import 'package:db_miner/view/screens/fav_page.dart';
import 'package:db_miner/view/screens/home_page.dart';
import 'package:db_miner/view/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    getPages: [
      GetPage(name: '/', page: () => SplashScreen()),
      GetPage(name: '/homepage', page: () => HomeScreen()),
      GetPage(name: '/detailpage', page: () => DetailPage()),
      GetPage(name: '/wishlist', page: () => WishList()),
    ],
  ));
}