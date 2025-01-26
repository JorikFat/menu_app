import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/catalog/catalog_cubit.dart';
import 'package:menu_app/widgets_ext.dart';
import 'package:menu_app/core.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_count_cubit.dart';
import 'package:menu_app/features/cart/cart_widget.dart';
import 'package:menu_app/features/catalog/catalog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  final CartBloc cart = CartBloc();
  late final CatalogCubit catalog = CatalogCubit(cart);
  late final CartCountCubit cartCountCubit = CartCountCubit(cart);
  int _pageIndex = 0;
  late final List<Widget> pages = [
    CatalogWidget(catalog),
    CartWidget(cart),
  ];

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
            icon: BlocBuilder<CartCountCubit, int>(
                bloc: cartCountCubit,
                builder: (context, state) =>
                    const Icon(Icons.shopping_cart).badge(state)),
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
