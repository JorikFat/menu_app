import 'package:menu_app/features/product.dart';

sealed class CartListEvent {
  const CartListEvent();
}

class CartListAddProductEvent extends CartListEvent {
  final Product product;

  CartListAddProductEvent(this.product);
}

class CartListRemoveProductEvent extends CartListEvent {
  final Product product;

  CartListRemoveProductEvent(this.product);
}

class CartListUpdateEvent extends CartListEvent {
  final Map<Product, int> cartState;
  
  CartListUpdateEvent(this.cartState);
}