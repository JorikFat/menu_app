import 'package:menu_app/features/product.dart';

class CartController {
  final Map<Product, int> _productsCount = {};

  int get count => _productsCount.isEmpty
      ? 0
      : _productsCount.values.reduce((value, element) => value + element);

  Map<Product, int> get state => Map.unmodifiable(_productsCount);

  int countOf(Product product) => _productsCount[product] ?? 0;

  void addProduct(Product product) {
    final int count = countOf(product);
    _productsCount[product] = count + 1;
  }

  void removeProduct(Product product) {
    final int count = _productsCount[product]!;
    if (count == 1) {
      _productsCount.remove(product);
    } else {
      _productsCount[product] = count - 1;
    }
  }
}
