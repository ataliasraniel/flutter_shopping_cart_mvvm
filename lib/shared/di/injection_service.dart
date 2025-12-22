import 'dart:developer';

import 'package:flutter_shopping_cart_mvvm/modules/cart/cart_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/infrastructure/api/checkout_api.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/cart_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/infrastructure/api/product_api.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

void setupInjections() async {
  log("Starting registrations...");
  injector.registerSingleton<CheckoutApi>(CheckoutApi());
  injector.registerSingleton<ProductApi>(ProductApi());
  injector.registerSingleton<CartService>(CartService(injector<CheckoutApi>()));
  //factories
  injector.registerFactory(() => HomeViewModel(injector<ProductApi>(), injector<CartService>()));
  injector.registerFactory(() => CartViewModel(injector<CartService>()));

  await injector.allReady();
  log("Registrations done.");
}
