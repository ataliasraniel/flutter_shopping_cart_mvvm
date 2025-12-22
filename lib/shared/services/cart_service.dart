import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/infrastructure/api/checkout_api.dart';

import '../entities/models/cart_item.dart';

class CartService with ChangeNotifier {
  final CheckoutApi _checkoutApi;
  CartService(this._checkoutApi);
  final List<CartItem> _items = [];
  int get itemsCount => _items.length;

  List<CartItem> get items => List.unmodifiable(_items);
  final _itemSingleLimit = 10;

  void addItem(CartItem item) {
    final index = _items.indexWhere((element) => element.productId == item.productId);
    if (index != -1) {
      final existingItem = _items[index];
      if (existingItem.quantity + item.quantity <= _itemSingleLimit) {
        _items[index] = CartItem(productId: existingItem.productId, quantity: existingItem.quantity + item.quantity, product: existingItem.product);
      }
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void decreaseItemByQuantity(CartItem item) {
    final index = _items.indexWhere((element) => element.productId == item.productId);
    if (index != -1) {
      final existingItem = _items[index];
      final newQuantity = existingItem.quantity - item.quantity;
      if (newQuantity > 0) {
        _items[index] = CartItem(productId: existingItem.productId, quantity: newQuantity, product: existingItem.product);
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(int productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  Future<CheckoutResponseModel> proceedToCheckout() async {
    final result = await _checkoutApi.processCheckout(_items);
    return result;
  }
}
