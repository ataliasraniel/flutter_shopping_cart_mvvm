import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/cart/cart_view.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view.dart';
import 'package:flutter_shopping_cart_mvvm/modules/order_completed/order_completed_view.dart';

class AppRoutes {
  AppRoutes._();
  static const String home = '/home';
  static const String cartScreen = '/cart';
  static const String orderCompleted = '/order_completed';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const Homeview(),
      cartScreen: (context) => const CartView(),
      orderCompleted: (context) => const OrderCompletedView(),
    };
  }
}
