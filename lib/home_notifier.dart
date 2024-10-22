import 'package:flutter/material.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_states.dart';

class HomeNotifier extends ValueNotifier<int> {
  final CartBloc cart;

  HomeNotifier(this.cart) :super(0){
    cart.stream.listen(_listenCart);
  }

  void _listenCart(CartState state){
    switch(state){
      case CartEmptyState():
        value = 0;
        break;
      case CartDataState():
        value = state.products.map((it) => it.count).reduce((a, b) => a + b);
        break;
    }
  }


  
}