import 'package:menu_app/features/product.dart';

class CartProduct extends Product {
  final int count;

  CartProduct(
    this.count,
    super.name,
    super.price,
  );

  CartProduct.product(Product product, [this.count = 0])
      : super(
          product.name,
          product.price,
        );

  int get amount => price * count;

  @override
  String toString() => '$name, price:$price, count:$count';

  @override
  int get hashCode => super.hashCode + count;

  @override
  bool operator ==(Object other) =>
      other is CartProduct && super == other && count == other.count;
}
