import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/cart_item.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/cart_service.dart';

enum CheckoutState { initial, loading, success, error }

class CartViewModel with ChangeNotifier {
  final CartService _cartService;
  CartViewModel(this._cartService);

  CheckoutState _checkoutState = CheckoutState.initial;
  String _errorMessage = '';
  CheckoutResponseModel? checkoutResponse;

  List<CartItem> get cartItems => _cartService.items;
  CheckoutState get checkoutState => _checkoutState;
  String get errorMessage => _errorMessage;

  double get subtotal {
    return _cartService.items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  double get total => subtotal;

  void addProductToCart(Product product) {
    _cartService.addItem(CartItem(productId: product.id, quantity: 1, product: product));
    notifyListeners();
  }

  void decreaseProductFromCart(Product product) {
    _cartService.decreaseItemByQuantity(CartItem(productId: product.id, quantity: 1, product: product));
    notifyListeners();
  }

  void removeItemFromCart(int productId) {
    _cartService.removeItem(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartService.clearCart();
    notifyListeners();
  }

  Future<bool> checkout() async {
    _checkoutState = CheckoutState.loading;
    notifyListeners();

    try {
      checkoutResponse = await _cartService.proceedToCheckout();
      _checkoutState = CheckoutState.success;
      clearCart();
      notifyListeners();
      return true;
    } catch (e) {
      _checkoutState = CheckoutState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
