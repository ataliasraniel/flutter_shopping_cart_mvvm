import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/di/injection_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/navigation/app_routes.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';
import 'package:flutter_shopping_cart_mvvm/shared/utils/formatters/money_formatter_utils.dart';
import 'package:flutter_shopping_cart_mvvm/shared/widgets/core/cart_badge.dart';

import 'components/product_card.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  final HomeViewModel _viewModel = injector.get();

  @override
  void initState() {
    _viewModel.fetchProducts();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (_, value) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Lojinha do Atalias', style: TextStyle(fontWeight: FontWeight.bold)),
            actionsPadding: const EdgeInsets.only(right: kMediumSize),
            actions: [GlobalCartBadge()],
          ),
          body: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _viewModel.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: kSmallSize),

                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: kMediumSize, vertical: kSmallSize),
                          decoration: BoxDecoration(
                            color: _viewModel.categories[index] == _viewModel.selectedCategory ? Colors.black : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () {
                              _viewModel.selectProductsByCategory(_viewModel.categories[index]);
                            },
                            child: Center(
                              child: Text(
                                _viewModel.categories[index],
                                style: TextStyle(
                                  color: _viewModel.categories[index] == _viewModel.selectedCategory ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: kMediumSize),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: <Widget>[
                      SizedBox(height: kMediumSize),
                      if (_viewModel.state == ScreenState.loading)
                        const Center(child: CircularProgressIndicator())
                      else if (_viewModel.state == ScreenState.error)
                        const Center(child: Text('Erro ao carregar produtos'))
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: _viewModel.products.length,
                            itemBuilder: (context, index) {
                              final product = _viewModel.products[index];
                              return ProductCard(
                                product: product,
                                quantity: _viewModel.itemQuantityInCart(product.id),
                                onDecreseQuantity: () {
                                  _viewModel.decreaseProductFromCart(product);
                                },
                                onAddToCart: () {
                                  _viewModel.addProductToCart(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.title} adicionado ao carrinho'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
