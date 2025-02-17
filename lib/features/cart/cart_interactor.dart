import 'dart:async';

import 'package:menu_app/features/cart/cart_controller.dart';
import 'package:menu_app/features/product.dart';

class CartInteractor {
  final CartController _controller;
  final _streamController = StreamController<Map<Product, int>>.broadcast();

  CartInteractor(this._controller);

  Map<Product, int> get state => _controller.state;

  void add(Product product) {
    _controller.addProduct(product);
    _streamController.add(_controller.state);
  }

  void remove(Product product) {
    _controller.removeProduct(product);
    _streamController.add(_controller.state);
  }

  void listen(
    void Function(Map<Product, int>) onData, {
    void Function(Object error)? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _streamController.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
}
