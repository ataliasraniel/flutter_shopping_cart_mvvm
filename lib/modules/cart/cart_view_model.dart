import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/cart_item.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/mixins/api_error_handler_mixin.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/cart_service.dart';

enum CheckoutState { initial, loading, success, error }

class CartViewModel with ChangeNotifier, ApiErrorHandlerMixin {
  final CartService _cartService;
  CartViewModel(this._cartService) {
    _cartService.addListener(notifyListeners);
  }

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
  }

  void decreaseProductFromCart(Product product) {
    _cartService.decreaseItemByQuantity(CartItem(productId: product.id, quantity: 1, product: product));
  }

  void removeItemFromCart(int productId) {
    _cartService.removeItem(productId);
  }

  void clearCart() {
    _cartService.clearCart();
  }

  Future<bool> checkout() async {
    _checkoutState = CheckoutState.loading;
    notifyListeners();

    try {
      checkoutResponse = await _cartService.proceedToCheckout();
      _checkoutState = CheckoutState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _checkoutState = CheckoutState.error;
      _errorMessage = handleApiError(e);
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _cartService.removeListener(notifyListeners);
    super.dispose();
  }
}
