import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_controller.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/product.dart';

class CartCubit extends Cubit<Map<Product, int>> {
  final CartController _controller;

  static CartProduct toCartProduct(MapEntry<Product, int> pair) =>
      CartProduct.product(pair.key, pair.value);

  factory CartCubit.def() {
    return CartCubit(CartController());
  }

  CartCubit(this._controller) : super(_controller.state);

  void add(Product product){
    _controller.addProduct(product);
    emit(_controller.state);
  }

  void remove(Product product){
    _controller.removeProduct(product);
    emit(_controller.state);
  }
}
