import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/infrastructure/api/checkout_api.dart';
import 'package:flutter_shopping_cart_mvvm/shared/infrastructure/api/cart_api.dart';

import '../entities/models/cart_item.dart';

class CartService with ChangeNotifier {
  final CheckoutApi _checkoutApi;
  final CartApi _cartApi;
  CartService(this._checkoutApi, this._cartApi);
  final List<CartItem> _items = [];
  int get itemsCount => _items.length;

  List<CartItem> get items => List.unmodifiable(_items);
  final _itemSingleLimit = 10;

  Future<void> addItem(CartItem item) async {
    try {
      final response = await _cartApi.addItemToCart(item);

      if (!response.success) {
        throw Exception(response.message);
      }

      final index = _items.indexWhere((element) => element.productId == item.productId);
      if (index != -1) {
        final existingItem = _items[index];
        if (existingItem.quantity + item.quantity <= _itemSingleLimit) {
          _items[index] = CartItem(
            productId: existingItem.productId,
            quantity: existingItem.quantity + item.quantity,
            product: existingItem.product,
          );
        }
      } else {
        _items.add(item);
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao adicionar item ao carrinho: $e');
    }
  }

  Future<void> decreaseItemByQuantity(CartItem item) async {
    try {
      final index = _items.indexWhere((element) => element.productId == item.productId);
      if (index != -1) {
        final existingItem = _items[index];
        final newQuantity = existingItem.quantity - item.quantity;

        if (newQuantity > 0) {
          final response = await _cartApi.updateItemQuantity(item.productId, newQuantity);
          if (!response.success) {
            throw Exception(response.message);
          }
          _items[index] = CartItem(productId: existingItem.productId, quantity: newQuantity, product: existingItem.product);
        } else {
          final response = await _cartApi.removeItemFromCart(item.productId);
          if (!response.success) {
            throw Exception(response.message);
          }
          _items.removeAt(index);
        }
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Erro ao atualizar item do carrinho: $e');
    }
  }

  Future<void> removeItem(int productId) async {
    try {
      final response = await _cartApi.removeItemFromCart(productId);
      if (!response.success) {
        throw Exception(response.message);
      }

      _items.removeWhere((item) => item.productId == productId);
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao remover item do carrinho: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      final response = await _cartApi.clearCart();
      if (!response.success) {
        throw Exception(response.message);
      }
    } catch (e) {
      throw Exception('Erro ao limpar carrinho: $e');
    }
  }

  Future<CheckoutResponseModel> proceedToCheckout() async {
    final result = await _checkoutApi.processCheckout(_items);
    await clearCart();
    return result;
  }

  Future<void> syncWithServer() async {
    try {
      final response = await _cartApi.syncCart(_items);
      if (!response.success) {
        throw Exception(response.message);
      }
    } catch (e) {
      throw Exception('Erro ao sincronizar carrinho: $e');
    }
  }

  Future<void> loadCartFromServer() async {
    try {
      final serverItems = await _cartApi.getCart();
      _items.clear();
      _items.addAll(serverItems);
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao carregar carrinho do servidor: $e');
    }
  }
}
