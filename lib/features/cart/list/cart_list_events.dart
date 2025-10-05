import 'package:menu_app/features/cart/list/cart_list_states.dart';
import 'package:menu_app/features/product/product.dart';

sealed class CartListEvent {
  const CartListEvent();
}

class CartListAddProductEvent extends CartListEvent {
  final ProductCartViewState product;

  CartListAddProductEvent(this.product);
}

class CartListRemoveProductEvent extends CartListEvent {
  final ProductCartViewState product;

  CartListRemoveProductEvent(this.product);
}

class CartListUpdateEvent extends CartListEvent {
  final Map<Product, int> cartState;

  CartListUpdateEvent(this.cartState);
}