import 'package:menu_app/features/product.dart';

class CartController {
  final Map<Product, int> _productsCount = {};

  Map<Product, int> get state {
    return Map.unmodifiable(_productsCount);
  }

  void addProduct(Product product) {
    final int count = _productsCount[product] ?? 0;
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
