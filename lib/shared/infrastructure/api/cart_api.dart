import 'dart:math';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/cart_item.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/cart_response_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/network/http_service.dart';

class CartApi {
  final HttpService _httpService;
  final Random _random = Random();
  CartApi(this._httpService);

  Future<List<CartItem>> getCart() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  Future<CartResponseModel> addItemToCart(CartItem item) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      if (_random.nextInt(10) == 0) {
        throw Exception('Erro de rede ao adicionar item');
      }

      return CartResponseModel(
        success: true,
        message: 'Item adicionado ao carrinho',
        data: CartResponseData(
          item: CartItemData(
            productId: item.productId,
            quantity: item.quantity,
            product: ProductData(id: item.product.id, title: item.product.title, price: item.product.price, image: item.product.image),
          ),
        ),
      );
    } catch (e) {
      return CartResponseModel(success: false, message: 'Erro ao adicionar item: ${e.toString()}');
    }
  }

  Future<CartResponseModel> updateItemQuantity(int productId, int quantity) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      if (_random.nextInt(15) == 0) {
        throw Exception('Erro de conexão ao atualizar quantidade');
      }

      return CartResponseModel(
        success: true,
        message: 'Quantidade atualizada',
        data: CartResponseData(productId: productId, newQuantity: quantity),
      );
    } catch (e) {
      return CartResponseModel(success: false, message: 'Erro ao atualizar quantidade: ${e.toString()}');
    }
  }

  Future<CartResponseModel> removeItemFromCart(int productId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      if (_random.nextInt(12) == 0) {
        throw Exception('Erro ao remover item do servidor');
      }

      return CartResponseModel(
        success: true,
        message: 'Item removido do carrinho',
        data: CartResponseData(productId: productId),
      );
    } catch (e) {
      return CartResponseModel(success: false, message: 'Erro ao remover item: ${e.toString()}');
    }
  }

  Future<CartResponseModel> clearCart() async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));

      if (_random.nextInt(20) == 0) {
        throw Exception('Erro de servidor ao limpar carrinho');
      }

      return CartResponseModel(success: true, message: 'Carrinho limpo com sucesso');
    } catch (e) {
      return CartResponseModel(success: false, message: 'Erro ao limpar carrinho: ${e.toString()}');
    }
  }

  Future<CartResponseModel> syncCart(List<CartItem> items) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      if (_random.nextInt(8) == 0) {
        throw Exception('Erro de sincronização com servidor');
      }

      return CartResponseModel(
        success: true,
        message: 'Carrinho sincronizado',
        data: CartResponseData(itemsCount: items.length),
      );
    } catch (e) {
      return CartResponseModel(success: false, message: 'Erro ao sincronizar carrinho: ${e.toString()}');
    }
  }
}
