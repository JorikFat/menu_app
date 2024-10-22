import 'package:menu_app/features/catalog/product.dart';

class CartProduct extends Product {
  final int count;

  CartProduct(
    this.count,
    super.name,
    super.price,
  );

  CartProduct.zero(Product product) :count = 0, super(product.name, product.price);

  CartProduct.product(Product product, [this.count = 1])
      : super(
          product.name,
          product.price,
        );

  int get amount => price * count;
}
