import 'dart:async';

import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/product.dart';

class CatalogInteractorCubit {
  final _streamController = StreamController<Map<Product, int>>.broadcast();
  final CartInteractor cart;
  final CatalogController controller;

  CatalogInteractorCubit(this.controller, this.cart) {
    cart.listen(_updateCatalog);
    controller
        .init()
        .then((catalog) => _streamController.add(_mapCartProducts(catalog, cart.state)));
  }

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
    onData.call(_mapCartProducts(controller.state, cart.state));
  }

  void _updateCatalog(Map<Product, int> cartProducts) {
    _streamController.add(_mapCartProducts(controller.state, cart.state));
  }

  Map<Product, int> _mapCartProducts(
    List<Product> catalog,
    Map<Product, int> cart,
  ) =>
      Map.fromEntries(catalog.map((it) => MapEntry(it, cart[it] ?? 0)));
}
