import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/product/product.dart';

sealed class CartListEvent {
  const CartListEvent();
}

class CartListAddProductEvent extends CartListEvent {
  final CartProduct product;

  CartListAddProductEvent(this.product);
}

class CartListRemoveProductEvent extends CartListEvent {
  final CartProduct product;

  CartListRemoveProductEvent(this.product);
}

class CartListUpdateEvent extends CartListEvent {
  final Map<Product, int> cartState;

  CartListUpdateEvent(this.cartState);
}