import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/modules/cart/cart_view_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/di/injection_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';
import 'package:flutter_shopping_cart_mvvm/shared/utils/formatters/money_formatter_utils.dart';
import 'package:flutter_shopping_cart_mvvm/shared/widgets/buttons/primary_button.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartViewModel viewModel = injector.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          if (viewModel.cartItems.isEmpty) {
            return const Center(child: Text('Seu carrinho está vazio'));
          }

          return Padding(
            padding: kDefaultPadding,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.cartItems[index];
                      final subtotal = item.quantity * item.product.price;
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: kSmallSize),
                        padding: const EdgeInsets.all(kSmallSize),
                        child: Row(
                          children: <Widget>[
                            Image.network(item.product.image, width: 60, height: 60),
                            const SizedBox(width: kSmallSize),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(MoneyFormatterUtils.format(subtotal), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

                                      Container(
                                        margin: const EdgeInsets.only(left: kMediumSize),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove_circle_outline),
                                              onPressed: () {
                                                if (item.quantity == 1) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        title: const Text('Remover Item'),
                                                        content: const Text('Deseja remover este item do carrinho?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text('Cancelar'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              viewModel.removeItemFromCart(item.productId);
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text('${item.product.title} removido do carrinho'),
                                                                  duration: const Duration(seconds: 1),
                                                                  backgroundColor: Colors.red,
                                                                ),
                                                              );
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text('Remover'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                  return;
                                                }
                                                viewModel.decreaseProductFromCart(item.product);
                                              },
                                            ),
                                            Text('${item.quantity}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                                            IconButton(
                                              icon: const Icon(Icons.add_circle_outline),
                                              onPressed: () {
                                                viewModel.addProductToCart(item.product);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Subtotal: ${MoneyFormatterUtils.format(viewModel.subtotal)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: kMediumSize),
                      PrimaryButton(label: 'Finalizar Pedido', onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
