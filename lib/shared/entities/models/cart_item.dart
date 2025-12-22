import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';

class CartItem {
  final int productId;
  final int quantity;
  final Product product;

  CartItem({required this.productId, required this.quantity, required this.product});
}
