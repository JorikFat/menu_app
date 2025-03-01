import 'package:menu_app/features/product.dart';

class CartProduct extends Product {
  final int count;

  CartProduct(
    this.count,
    super.name,
    super.price,
  );

  @deprecated
  CartProduct.product(Product product, [this.count = 0])
      : super(
          product.name,
          product.price,
        );

  int get amount => price * count;

  @override
  int get hashCode => super.hashCode + count;

  @override
  bool operator ==(Object other) =>
      super == other && other is CartProduct && other.count == count;

  @override
  String toString() => '$name, price:$price, count:$count';
}
