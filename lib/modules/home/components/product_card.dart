import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/entities/models/product.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_colors.dart';
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: kSmallSize,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: kSmallSize, vertical: kTinySize),
                  decoration: BoxDecoration(color: Colors.yellow[700]!.withAlpha(200), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.star, size: 12, color: Colors.white),
                      SizedBox(width: kSmallSize),
                      Text(product.rating.rate.toString(), style: TextStyle(fontSize: 10, color: Colors.white)),
                    ],
                  ),
                ),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(MoneyFormatterUtils.format(product.price), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                if (quantity > 0) ...[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            onDecreseQuantity();
                          },
                          icon: const Icon(Icons.remove, color: AppColors.primary),
                        ),
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            onAddToCart();
                          },
                          icon: const Icon(Icons.add, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ] else
                  PrimaryButton(
                    label: 'Adicionar ao carrinho',
                    icon: Icons.add,
                    onPrimary: false,
                    onPressed: () {
                      onAddToCart();
                    },
                  ),
              ],
            ),
          ),

          Expanded(child: Image.network(product.image, height: 100, fit: BoxFit.contain)),
          SizedBox(height: kMediumSize),
        ],
      ),
    );
  }
}
