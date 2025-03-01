import 'package:flutter/foundation.dart';
import 'package:menu_app/features/cart/cart_product.dart';

sealed class CartListState {
  const CartListState();
}

class CartEmptyState extends CartListState {
  const CartEmptyState();

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(Object other) =>
      other is CartEmptyState;      
}

class CartDataState extends CartListState {
  final List<CartProduct> list;

  const CartDataState(this.list);

  @override
  String toString() => 'CartDataState$list';

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) =>
      other is CartDataState && listEquals(list, other.list);
}
