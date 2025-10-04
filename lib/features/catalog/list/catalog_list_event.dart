import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/product/product.dart';

sealed class CatalogListEvent {
  const CatalogListEvent();
}

class CatalogListUpdateEvent extends CatalogListEvent {
  final List<CartProduct> products;

  const CatalogListUpdateEvent(this.products);
}

class CatalogListAddEvent extends CatalogListEvent{
  final Product product;

  const CatalogListAddEvent(this.product);
}