import 'package:menu_app/features/cart/cart_product.dart';

sealed class CatalogListState {
  const CatalogListState();
}

class CatalogLoadState extends CatalogListState {
  const CatalogLoadState();
}

class CatalogDataState extends CatalogListState {
  final List<CartProduct> products;

  const CatalogDataState(this.products);
}