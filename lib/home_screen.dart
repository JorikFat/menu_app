import 'package:flutter/material.dart';
import 'package:menu_app/core.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_widget.dart';
import 'package:menu_app/features/catalog/catalog_bloc.dart';
import 'package:menu_app/features/catalog/catalog_widget.dart';
import 'package:menu_app/home_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  final CartBloc cart = CartBloc();
  late final CatalogBloc catalog = CatalogBloc(cart);
  late final HomeNotifier homeNotifier = HomeNotifier(cart);
  int _pageIndex = 0;
  late final List<Widget> pages = [CatalogWidget(catalog), CartWidget(cart)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _changePage,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Каталог",
          ),
          BottomNavigationBarItem(
            icon: ValueListenableBuilder<int>(
              valueListenable: homeNotifier,
              builder: (context, value, _) => Badge(
                label: Text(value.toString()),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
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
