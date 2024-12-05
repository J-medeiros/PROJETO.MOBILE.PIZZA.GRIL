import 'package:flutter/material.dart';
import 'package:pizzaria_app/recursos/produtos/product_details_screen.dart';
import 'package:pizzaria_app/recursos/produtos/shopping_screen.dart';
import 'recursos/autenticacao/paginas/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzaria App',
      theme: ThemeData(primarySwatch: Colors.yellow),
      supportedLocales: const [
        Locale('pt', 'BR'), // Português do Brasil
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: {
        '/shopping': (context) => const ShoppingScreen(),
        '/details': (constex) => const ProductDetailsScreen(
              product: {},
            ),
        // '/favorites': (context) => FavoritesScreen(),
        // '/cart': (context) => CartScreen(),
        // '/orders': (context) => OrdersScreen(),
      },
      home: LoginScreen(),
    );
  }
}
