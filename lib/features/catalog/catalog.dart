import 'package:menu_app/features/product/product.dart';

class Catalog {
  List<Product> _products = [];

  List<Product> get state => List.unmodifiable(_products);

  void init(List<Product> products) {
    _products = products;
  }
}