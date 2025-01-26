import 'package:menu_app/features/catalog/catalog_stub_source.dart';
import 'package:menu_app/features/product.dart';

class CatalogController {
  late final List<Product> _product;

  List<Product> get state => List.unmodifiable(_product);

  Future<List<Product>> init() async {
    _product = await CatalogStubSource.fetchProducts();
    return _product;
  }
}