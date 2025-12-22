import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/di/injection_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/services/cart_service.dart';

class GlobalCartBadge extends StatelessWidget {
  const GlobalCartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = injector.get<CartService>();
    return ListenableBuilder(
      listenable: cartService,
      builder: (context, value) {
        // return Container(
        //   padding: const EdgeInsets.all(6),
        //   decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        //   child: Text('${cartService.itemsCount}', style: const TextStyle(color: Colors.white, fontSize: 12)),
        // );
        if (cartService.itemsCount == 0) {
          return const SizedBox.shrink();
        }
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const Icon(Icons.shopping_cart),
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/cart');
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '${cartService.itemsCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
