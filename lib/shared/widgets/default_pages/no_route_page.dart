import 'package:flutter/material.dart';

class NoRoutePage extends StatelessWidget {
  const NoRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rota Não Encontrada'), centerTitle: true),
      body: const Center(child: Text('A rota solicitada não foi encontrada.', style: TextStyle(fontSize: 18))),
    );
  }
}
