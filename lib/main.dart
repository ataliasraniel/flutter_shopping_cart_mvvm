import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/shared/di/injection_service.dart';
import 'package:flutter_shopping_cart_mvvm/shared/navigation/app_routes.dart';
import 'package:flutter_shopping_cart_mvvm/shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjections();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      theme: AppTheme.lightTheme,

      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
