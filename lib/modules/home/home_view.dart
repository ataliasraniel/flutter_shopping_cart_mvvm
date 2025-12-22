import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/di/injection_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';
import 'package:flutter_shopping_cart_mvvm/shared/utils/formatters/money_formatter_utils.dart';
import 'package:flutter_shopping_cart_mvvm/shared/widgets/core/cart_badge.dart';

import 'components/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          appBar: AppBar(title: const Text('Atalia\'s Store'), actions: [GlobalCartBadge()]),
          body: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _viewModel.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kSmallSize),
                        child: ChoiceChip(
                          label: Text(_viewModel.categories[index]),
                          selected: _viewModel.categories[index] == _viewModel.getSelectedCategory,
                          onSelected: (bool selected) {
                            _viewModel.selectProductsByCategory(_viewModel.categories[index]);
                          },
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
                      const Text('Veja nossos produtos'),
                      SizedBox(height: kMediumSize),
                      if (_viewModel.state == ScreenState.loading)
                        const Center(child: CircularProgressIndicator())
                      else if (_viewModel.state == ScreenState.error)
                        const Center(child: Text('Erro ao carregar produtos'))
                      else
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: kMediumSize,
                              mainAxisSpacing: kMediumSize,
                              childAspectRatio: 0.5,
                            ),
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
