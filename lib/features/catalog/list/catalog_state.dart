import 'package:menu_app/features/cart/cart_product.dart';

sealed class CatalogState {
  const CatalogState();
}

class CatalogLoadState extends CatalogState {
  const CatalogLoadState();
}

class CatalogDataState extends CatalogState {
  final List<CartProduct> products;

  const CatalogDataState(this.products);
}