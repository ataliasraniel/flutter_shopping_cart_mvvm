import 'package:flutter_shopping_cart_mvvm/shared/entities/models/cart_item.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';

class CheckoutApi {
  // final HttpService _httpService = HttpService();

  Future<CheckoutResponseModel> processCheckout(List<CartItem> items) async {
    await Future.delayed(const Duration(seconds: 2));
    final random = DateTime.now().millisecondsSinceEpoch;
    if (random % 2 == 0) {
      throw Exception('Estamos fora do ar, desculpe =(.');
    }
    return CheckoutResponseModel(message: 'Checkout realizado com sucesso!', success: true, orderId: random);
  }
}
