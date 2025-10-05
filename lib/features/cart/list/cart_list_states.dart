import 'package:flutter/foundation.dart';
import 'package:menu_app/features/product/product.dart';

sealed class CartListState {
  const CartListState();
}

class CartEmptyState extends CartListState {
  const CartEmptyState();

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(Object other) => other is CartEmptyState;
}

class CartDataState extends CartListState {
  final List<ProductCartViewState> list;

  const CartDataState(this.list);

  @override
  String toString() => 'CartDataState$list';

  @override
  int get hashCode => 0; //FIXME

  @override
  bool operator ==(Object other) =>
      other is CartDataState && listEquals(list, other.list);
}

class ProductCartViewState {
  final String name;
  final String count;
  final String amount;

  ProductCartViewState({
    required this.name,
    required this.count,
    required this.amount,
  });

  ProductCartViewState.product(
    Product product, {
    int count = 1,
  })  : name = product.name,
        count = count.toString(),
        amount = "сумма: ${product.price * count}р";

  @override
  int get hashCode =>
      name.hashCode * 31 + count.hashCode * 31 + amount.hashCode * 31;

  @override
  bool operator ==(Object other) =>
      other is ProductCartViewState &&
      other.name == name &&
      other.amount == amount &&
      other.count == count;
}
