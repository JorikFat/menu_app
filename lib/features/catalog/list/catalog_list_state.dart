import 'package:menu_app/features/cart/cart_product.dart';

sealed class CatalogListState {
  const CatalogListState();

  const factory CatalogListState.load() = CatalogLoadState;
  const factory CatalogListState.data(List<CartProduct> data) = CatalogDataState;
}

class CatalogLoadState extends CatalogListState {
  const CatalogLoadState();
}

class CatalogDataState extends CatalogListState {
  final List<CartProduct> products;

  const CatalogDataState(this.products);
}