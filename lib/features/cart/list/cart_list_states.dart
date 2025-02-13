import 'package:menu_app/features/cart/cart_product.dart';

sealed class CartListState {
  const CartListState();
}

class CartEmptyState extends CartListState{
  const CartEmptyState();
}

class CartDataState extends CartListState {
  final List<CartProduct> list;

  const CartDataState(this.list);
}