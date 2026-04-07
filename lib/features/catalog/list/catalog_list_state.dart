import 'package:menu_app/features/product/product.dart';

sealed class CatalogListState {
  const CatalogListState();

  const factory CatalogListState.load() = CatalogLoadState;
  const factory CatalogListState.data(Map<Product, int?> data) = CatalogDataState;
}

class CatalogLoadState extends CatalogListState {
  const CatalogLoadState();
}

class CatalogDataState extends CatalogListState {
  final Map<Product, int?> products;

  const CatalogDataState(this.products);
}