import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view.dart';

class AppRoutes {
  static const String home = '/home';
  static const String cartScreen = '/cart';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      // cartScreen: (context) => const CartScreen(),
    };
  }
}
