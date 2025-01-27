import 'package:menu_app/features/product.dart';

class CatalogController {
  final CatalogSource _source;
  late final List<Product> _product;

  CatalogController(this._source);

  List<Product> get state => List.unmodifiable(_product);

  Future<List<Product>> init() async {
    _product = await _source.fetchProducts();
    return _product;
  }
}

abstract interface class CatalogSource {
  Future<List<Product>> fetchProducts();
}