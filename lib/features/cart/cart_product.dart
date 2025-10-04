import 'package:menu_app/features/product/product.dart';

class CartProduct {
  final Product _product;
  final int count;

  CartProduct(
    this.count,
    this._product,
  );

  int get amount => _product.price * count;

  String get name => _product.name;

  int get price => _product.price;

  Product get product => _product;

  @override
  String toString() =>
      '$runtimeType: ${_product.name}, price:${_product.price}, count:$count';

  @override
  int get hashCode => product.hashCode + 31 * count;

  @override
  bool operator ==(Object other) =>
      other is CartProduct && other.product == product && other.count == count;
}
