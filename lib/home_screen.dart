import 'package:flutter/material.dart';
import 'package:menu_app/core.dart';
import 'package:menu_app/features/catalog/catalog_bloc.dart';
import 'package:menu_app/features/catalog/catalog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  final CatalogBloc catalog = CatalogBloc();
  int _pageIndex = 0;
  late final List<Widget> pages = [
    CatalogWidget(catalog),
    CatalogWidget(catalog)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: CatalogWidget(catalog),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Каталог",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Корзина",
            
          )
        ],
      ),
    );
  }

  void _changePage(int index) {
    _pageIndex = index;
    setState(() {});
  }
}
