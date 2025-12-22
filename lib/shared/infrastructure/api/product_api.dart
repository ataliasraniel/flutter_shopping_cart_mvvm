import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/network/http_service.dart';

class ProductApi {
  final HttpService _httpService;
  ProductApi(this._httpService);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _httpService.get<List<dynamic>?>('/products');
      if (response == null) {
        throw Exception('Failed to fetch products: empty response');
      }
      return response.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _httpService.get<Map<String, dynamic>?>('/products/$id');
      if (response == null) {
        throw Exception('Failed to fetch product with id $id: empty response');
      }
      return Product.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch product with id $id: $e');
    }
  }
}
