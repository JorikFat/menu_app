import 'package:flutter/material.dart';
import 'package:menu_app/features/cart/cart_providers.dart';
import 'package:menu_app/features/catalog/catalog_providers.dart';
import 'package:menu_app/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...cartProviders,
        ...catalogProviders,
      ],
      child: MaterialApp(
        title: "Menu App",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
