import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/network/http_service.dart';

class ProductApi {
  final HttpService _httpService = HttpService();
  Future<List<Product>> getAllProducts() async {
    final response = await _httpService.get<List<dynamic>>('/products');
    return response.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProductById(int id) async {
    final response = await _httpService.get<Map<String, dynamic>>('/products/$id');
    return Product.fromJson(response);
  }
}
