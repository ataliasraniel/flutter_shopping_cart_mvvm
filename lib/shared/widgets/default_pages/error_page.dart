import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro'), centerTitle: true),
      body: const Center(child: Text('Ocorreu um erro ao carregar a página.', style: TextStyle(fontSize: 18))),
    );
  }
}
