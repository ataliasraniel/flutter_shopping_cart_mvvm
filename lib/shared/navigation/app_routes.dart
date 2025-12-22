import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/cart/cart_view.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view.dart';
import 'package:flutter_shopping_cart_mvvm/modules/order_completed/order_completed_view.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/widgets/default_pages/error_page.dart';

class AppRoutes {
  AppRoutes._();
  static const String home = '/home';
  static const String cartScreen = '/cart';
  static const String orderCompleted = '/order_completed';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const Homeview());
      case cartScreen:
        return MaterialPageRoute(builder: (context) => const CartView());
      case orderCompleted:
        if (arguments is CheckoutResponseModel) {
          return MaterialPageRoute(builder: (context) => OrderCompletedView(checkoutResponse: arguments));
        }
        return MaterialPageRoute(builder: (context) => const ErrorPage());
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
