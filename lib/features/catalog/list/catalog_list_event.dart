import 'package:menu_app/features/product/product.dart';

sealed class CatalogListEvent {
  const CatalogListEvent();

  const factory CatalogListEvent.update(Map<Product, int?> products) = CatalogListUpdateEvent;
  const factory CatalogListEvent.add(Product product) = CatalogListAddEvent;
}

class CatalogListUpdateEvent extends CatalogListEvent {
  final Map<Product, int?> products;

  const CatalogListUpdateEvent(this.products);
}

class CatalogListAddEvent extends CatalogListEvent{
  final Product product;

  const CatalogListAddEvent(this.product);
}