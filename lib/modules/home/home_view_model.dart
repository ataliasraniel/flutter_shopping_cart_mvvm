import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/cart_item.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/cart_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/infrastructure/api/product_api.dart';

enum ScreenState { initial, loading, loaded, error }

class HomeViewModel with ChangeNotifier {
  final ProductApi _productApi;
  final CartService _cartService;
  HomeViewModel(this._productApi, this._cartService) {
    _cartService.addListener(notifyListeners);
  }
  ScreenState _state = ScreenState.initial;
  final List<Product> _products = [];
  final List<String> _categories = [];
  String _selectedCategory = 'All';

  List<CartItem> get cartItems => _cartService.items;

  String get selectedCategory => _selectedCategory;
  ScreenState get state => _state;
  List<String> get categories => _categories;
  List<Product> get products => _products;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearCart() {
    _cartService.clearCart();
  }

  Future<void> fetchProducts() async {
    _state = ScreenState.loading;
    notifyListeners();
    try {
      final allProducts = await _productApi.fetchProducts();
      _products.clear();
      if (_selectedCategory == 'All') {
        _products.addAll(allProducts);
      } else {
        _products.addAll(allProducts.where((product) => product.category == _selectedCategory));
      }
      _categories.clear();
      _categories.addAll({'All', ...allProducts.map((e) => e.category).toSet()});
      if (_selectedCategory.isEmpty) {
        _selectedCategory = 'All';
      }
      _state = ScreenState.loaded;
    } catch (e) {
      _state = ScreenState.error;
    }
    notifyListeners();
  }

  Future<void> selectProductsByCategory(String category) async {
    _selectedCategory = category;
    await fetchProducts();
  }

  void addProductToCart(Product product) {
    _cartService.addItem(CartItem(productId: product.id, quantity: 1, product: product));
  }

  void decreaseProductFromCart(Product product) {
    _cartService.decreaseItemByQuantity(CartItem(productId: product.id, quantity: 1, product: product));
  }

  bool hasCurrentItemInCart(int productId) {
    return cartItems.any((item) => item.productId == productId);
  }

  int itemQuantityInCart(int productId) {
    final item = cartItems.firstWhere(
      (item) => item.productId == productId,
      orElse: () => CartItem(
        productId: productId,
        quantity: 0,
        product: Product(id: productId, title: '', price: 0, description: '', category: '', image: '', rating: Rating(rate: 0, count: 0)),
      ),
    );
    return item.quantity;
  }

  @override
  void dispose() {
    _cartService.removeListener(notifyListeners);
    super.dispose();
  }
}
