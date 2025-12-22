import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/home/home_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/data/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

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
                //lista horizontal de categorias
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
                Column(crossAxisAlignment: .start, children: <Widget>[const Text('Veja nossos produtos')]),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
