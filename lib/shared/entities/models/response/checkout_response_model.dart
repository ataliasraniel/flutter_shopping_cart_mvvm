import 'package:flutter_shopping_cart_mvvm/shared/entities/models/cart_item.dart';

class CheckoutResponseModel {
  final String message;
  final bool success;
  final int orderId;
  final CheckoutData data;
  CheckoutResponseModel({this.message = 'Checkout realizado com sucesso!', this.success = true, this.orderId = 0, required this.data});

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['data']['items'] as List<dynamic>;
    final items = itemsJson
        .map(
          (itemJson) => CheckoutItem(
            title: itemJson['product']['title'],
            image: itemJson['product']['image'] ?? '',
            price: (itemJson['product']['price'] as num).toDouble(),
            quantity: itemJson['quantity'] as int,
          ),
        )
        .toList();
    final subtotal = (json['data']['subtotal'] as num).toDouble();
    final frete = (json['data']['frete'] as num).toDouble();
    return CheckoutResponseModel(
      message: json['message'] as String,
      success: json['success'] as bool,
      orderId: json['orderId'] as int,
      data: CheckoutData(items: items, subtotal: subtotal, frete: frete),
    );
  }
}

class CheckoutData {
  final List<CheckoutItem> items;
  final double subtotal;
  final double frete;
  CheckoutData({required this.items, required this.subtotal, required this.frete});
}

class CheckoutItem {
  final String title;
  final String image;
  final double price;
  final int quantity;
  CheckoutItem({required this.quantity, required this.title, required this.image, required this.price});
}
