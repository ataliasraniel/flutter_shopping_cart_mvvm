import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/data/models/product.dart';

class HomeViewModel with ChangeNotifier {
  final List<Product> products = [];
  final List<String> _categories = ['electronics', 'jewelery', "men's clothing", "women's clothing"];
  String _selectedCategory = 'electronics';

  String get getSelectedCategory => _selectedCategory;

  List<String> get getCategories => _categories;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
