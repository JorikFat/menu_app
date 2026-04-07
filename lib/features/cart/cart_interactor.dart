import 'dart:async';

import 'package:menu_app/features/cart/cart.dart';
import 'package:menu_app/features/product/product.dart';

class CartInteractor {
  final Cart _cart;
  final _streamController = StreamController<Map<Product, int>>.broadcast();

  CartInteractor(this._cart);

  Map<Product, int> get state => _cart.state;
  Stream<Map<Product, int>> get stream => _streamController.stream;

  void add(Product product) {
    _cart.addProduct(product);
    _streamController.add(_cart.state);
  }

  void remove(Product product) {
    _cart.removeProduct(product);
    _streamController.add(_cart.state);
  }

  void purchase() {
    final order = _cart.state; //TODO: send order
    _cart.clear();
    _streamController.add(_cart.state);
  }
}
