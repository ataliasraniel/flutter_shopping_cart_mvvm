import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/response/checkout_response_model.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';
import 'package:flutter_shopping_cart_mvvm/shared/utils/formatters/money_formatter_utils.dart';
import 'package:flutter_shopping_cart_mvvm/shared/widgets/buttons/primary_button.dart';

class OrderCompletedView extends StatelessWidget {
  final CheckoutResponseModel checkoutResponse;
  const OrderCompletedView({super.key, required this.checkoutResponse});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Pedido Finalizado'), automaticallyImplyLeading: false, centerTitle: true),
        body: Padding(
          padding: kDefaultPadding,
          child: Column(
            crossAxisAlignment: .start,
            children: <Widget>[
              Text('Seu pedido - ${checkoutResponse.orderId}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              const SizedBox(height: kLargeSize),
              Expanded(
                child: ListView.builder(
                  itemCount: checkoutResponse.data.items.length,
                  itemBuilder: (_, index) {
                    final item = checkoutResponse.data.items[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: kMediumSize),
                      child: Row(
                        children: <Widget>[
                          Image.network(item.image, width: 60, height: 60, fit: BoxFit.cover),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text('Quantidade: ${item.quantity}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Text(
                            MoneyFormatterUtils.format((item.price * item.quantity)),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: kTinySize,

                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Resumo do Pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Subtotal:', style: TextStyle(fontSize: 16)),
                      Text('R\$ ${checkoutResponse.data.subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Frete:', style: TextStyle(fontSize: 16)),
                      Text('R\$ ${checkoutResponse.data.frete.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: kMediumSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      Text(
                        'R\$ ${(checkoutResponse.data.subtotal + checkoutResponse.data.frete).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: kLargeSize),
              PrimaryButton(
                isFullWidth: true,
                label: 'Novo Pedido',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
