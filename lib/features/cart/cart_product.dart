import 'package:menu_app/features/product/product.dart';

class CartProduct extends Product {
  final int count;

  CartProduct(
    this.count,
    super.name,
    super.price,
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
