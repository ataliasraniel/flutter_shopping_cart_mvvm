import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/di/injection_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';
import 'package:flutter_shopping_cart_mvvm/shared/utils/formatters/money_formatter_utils.dart';

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
          body: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _viewModel.getCategories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kSmallSize),
                        child: ChoiceChip(
                          label: Text(_viewModel.getCategories[index]),
                          selected: _viewModel.getCategories[index] == _viewModel.getSelectedCategory,
                          onSelected: (bool selected) {
                            _viewModel.selectCategory(_viewModel.getCategories[index]);
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
                              childAspectRatio: 0.6,
                            ),
                            itemCount: _viewModel.products.length,
                            itemBuilder: (context, index) {
                              final product = _viewModel.products[index];
                              return ProductCard(product: product);
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
