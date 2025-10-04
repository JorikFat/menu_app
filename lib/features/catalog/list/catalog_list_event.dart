import 'package:menu_app/features/cart/cart_product.dart';

sealed class CatalogListEvent {
  const CatalogListEvent();
}

class CatalogListUpdateEvent extends CatalogListEvent {
  final List<CartProduct> products;

  const CatalogListUpdateEvent(this.products);
}

class CatalogListAddEvent extends CatalogListEvent{
  final CartProduct product;

  const CatalogListAddEvent(this.product);
}