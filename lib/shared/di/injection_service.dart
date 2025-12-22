import 'dart:developer';

import 'package:flutter_shopping_cart_mvvm/modules/home/home_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/cart_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/product_api.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

void setupInjections() async {
  injector.registerSingleton<ProductApi>(ProductApi());
  injector.registerSingleton<CartService>(CartService());
  //factories
  injector.registerFactory(() => HomeViewModel(injector<ProductApi>(), injector<CartService>()));

  await injector.allReady();
  log("All ready.");
}
