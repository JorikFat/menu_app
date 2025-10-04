import 'package:menu_app/features/product/product.dart';

class CatalogController {
  final CatalogSource _source;
  final List<Product> _product = [];

  CatalogController(this._source);

  List<Product> get state => List.unmodifiable(_product);

  Future<List<Product>> init() async {
    _product.addAll(await _source.fetchProducts());
    return _product;
  }
}

abstract interface class CatalogSource {
  Future<List<Product>> fetchProducts();
}