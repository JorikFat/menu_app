import 'dart:async';

import 'package:menu_app/features/cart/cart.dart';
import 'package:menu_app/features/product/product.dart';

class CartInteractor {
  final Cart _cart;
  final _streamController = StreamController<Map<Product, int>>.broadcast();

  CartInteractor(this._cart);

  Map<Product, int> get state => _cart.state;

  void add(Product product) {
    _cart.addProduct(product);
    _streamController.add(_cart.state);
  }

  void remove(Product product) {
    _cart.removeProduct(product);
    _streamController.add(_cart.state);
  }

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
    onData(_cart.state);
  }

  void purchase() {
    final order = _cart.state;
    //TODO: send order
    _cart.clear();
    _streamController.add(_cart.state);
  }
}
