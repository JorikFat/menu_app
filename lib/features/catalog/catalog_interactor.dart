import 'dart:async';

import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/catalog/catalog.dart';
import 'package:menu_app/features/product/product.dart';

class CatalogInteractor {
  final CartInteractor cart;
  final Catalog catalog;
  final _streamController = StreamController<Map<Product, int>>.broadcast();

  CatalogInteractor({
    required this.catalog,
    required this.cart,
    required CatalogSource sourse,
  }) {
    sourse.fetchProducts().then((products) {
      catalog.init(products);
      _streamController.add(_mapCartProducts(catalog.state, cart.state));
      cart.stream.listen(_updateCatalog);
    });
  }

  Map<Product, int> get state => _mapCartProducts(catalog.state, cart.state);

  void addProduct(Product product) => cart.add(product);

  void listen(
    void Function(Map<Product, int>) onData, {
    void Function(Object error)? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    _streamController.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void _updateCatalog(Map<Product, int> cartProducts) {
    _streamController.add(_mapCartProducts(catalog.state, cart.state));
  }

  Map<Product, int> _mapCartProducts(
    List<Product> catalog,
    Map<Product, int> cart,
  ) =>
      Map.fromEntries(catalog.map((it) => MapEntry(it, cart[it] ?? 0)));
}

abstract interface class CatalogSource {
  Future<List<Product>> fetchProducts();
}
