import 'package:flutter_shopping_cart_mvvm/shared/entities/models/cart_item.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';

class CheckoutApi {
  // final HttpService _httpService = HttpService();

  Future<CheckoutResponseModel> processCheckout(List<CartItem> items) async {
    await Future.delayed(const Duration(seconds: 2));
    final random = DateTime.now().millisecondsSinceEpoch;
    if (random % 2 == 0) {
      throw Exception(_mapErrorCodeToMessage(500));
    }
    final mockedResponse = {
      'message': 'Checkout realizado com sucesso!',
      'success': true,
      'orderId': random,
      'data': {
        'frete': 12.50,
        'items': items
            .map(
              (item) => {
                'product': {'title': item.product.title, 'image': item.product.image, 'price': item.product.price},
                'quantity': item.quantity,
              },
            )
            .toList(),
        'subtotal': items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity)),
      },
    };
    return CheckoutResponseModel.fromJson(mockedResponse);
  }

  String _mapErrorCodeToMessage(int code) {
    switch (code) {
      case 400:
        return 'Requisição inválida. Por favor, verifique os dados enviados.';
      case 401:
        return 'Não autorizado. Por favor, faça login novamente.';
      case 500:
        return 'Estamos enfrentando problemas técnicos =(';
      default:
        return 'Ocorreu um erro desconhecido. Código: $code';
    }
  }
}
