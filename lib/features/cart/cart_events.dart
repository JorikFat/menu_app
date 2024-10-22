import 'package:menu_app/features/catalog/product.dart';

sealed class CartEvent {
  const CartEvent();
}

class CartAddProductEvent extends CartEvent {
  final Product product;

  CartAddProductEvent(this.product);
}

class CartRemoveProductEvent extends CartEvent {
  final Product product;

  CartRemoveProductEvent(this.product);
}