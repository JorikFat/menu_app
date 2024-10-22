import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';
import 'package:menu_app/features/catalog/catalog_event.dart';
import 'package:menu_app/features/catalog/product.dart';

class CatalogBloc extends Bloc<CatalogAddProductEvent, List<CartProduct>> {
  final CartBloc cart;

  CatalogBloc(this.cart) : super(stubProducts.map(CartProduct.zero).toList()) {
    on<CatalogAddProductEvent>(_addProduct);
    cart.stream.listen(_listenCart);
  }

  void _addProduct(
    CatalogAddProductEvent event,
    Emitter<List<CartProduct>> emit,
  ) {
    cart.add(CartAddProductEvent(event.product));
  }

  void _listenCart(CartState cartState){
    switch(cartState){
      case CartEmptyState(): 
        emit(state.map(CartProduct.zero).toList());
        break;
      case CartDataState():
        emit(state.map((it) => CartProduct.product(it, _productCount(it, cartState))).toList());
        break;
    }
  }

  int _productCount(CartProduct product, CartDataState cart){
    final contains = cart.products.contains(product);
    if (contains){
      final cartProduct = cart.products.firstWhere((it) => it.name == product.name);
      final index = cart.products.indexOf(cartProduct);
      return cart.products[index].count;
    } else {
      return 0;
    }
  }
}
