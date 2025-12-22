import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_spacing.dart';
import 'package:flutter_shopping_cart_mvvm/shared/utils/formatters/money_formatter_utils.dart';
import 'package:flutter_shopping_cart_mvvm/shared/widgets/buttons/primary_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onAddToCart;
  final VoidCallback onDecreseQuantity;
  const ProductCard({super.key, required this.product, required this.onAddToCart, required this.quantity, required this.onDecreseQuantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSmallSize),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            //rating
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kSmallSize, vertical: kTinySize),
              decoration: BoxDecoration(color: Colors.yellow[700], borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.star, size: 10, color: Colors.white),
                  SizedBox(width: kSmallSize),
                  Text(product.rating.rate.toString(), style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Image.network(product.image, height: 100, fit: BoxFit.contain),
                SizedBox(height: kSmallSize),
                Text(MoneyFormatterUtils.format(product.price), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: kSmallSize),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                //description
                SizedBox(height: kSmallSize),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: kMediumSize),
          if (quantity > 0) ...[
            Row(
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      onDecreseQuantity();
                    },
                    icon: const Icon(Icons.remove, color: Colors.orange),
                  ),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      onAddToCart();
                    },
                    icon: const Icon(Icons.add, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ] else
            PrimaryButton(
              label: 'Adicionar ao carrinho',
              onPressed: () {
                onAddToCart();
              },
            ),
        ],
      ),
    );
  }
}
