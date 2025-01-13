import 'package:flutter/material.dart';
import 'package:kan_kardesi/screens/home/home_screen.dart';
import 'package:kan_kardesi/screens/profile/profile_screen.dart';
import 'package:kan_kardesi/screens/search/search_screen.dart';

mixin MainMixin {
  List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
}
