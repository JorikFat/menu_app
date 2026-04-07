import 'package:flutter/material.dart';
import 'package:menu_app/features/cart/list/cart_list_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return cartBlocProvider(const CartListWidget());
  }
}
