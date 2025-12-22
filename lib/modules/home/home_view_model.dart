import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/product_api.dart';

enum ScreenState { initial, loading, loaded, error }

class HomeViewModel with ChangeNotifier {
  final ProductApi _productApi;
  HomeViewModel(this._productApi);
  ScreenState _state = ScreenState.initial;
  final List<Product> products = [];
  final List<String> _categories = ['electronics', 'jewelery', "men's clothing", "women's clothing"];
  String _selectedCategory = 'electronics';

  String get getSelectedCategory => _selectedCategory;
  ScreenState get state => _state;
  List<String> get getCategories => _categories;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _state = ScreenState.loading;
    notifyListeners();
    try {
      final allProducts = await _productApi.getAllProducts();
      products.clear();
      products.addAll(allProducts.where((product) => product.category == _selectedCategory));
      _state = ScreenState.loaded;
    } catch (e) {
      _state = ScreenState.error;
    }
    notifyListeners();
  }
}
