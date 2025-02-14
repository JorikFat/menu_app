import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_controller.dart';
import 'package:menu_app/features/product.dart';

class CartInteractorCubit extends Cubit<Map<Product, int>> {
  final CartController _controller;

  factory CartInteractorCubit.def() {
    return CartInteractorCubit(CartController());
  }

  CartInteractorCubit(this._controller) : super(_controller.state);

  void add(Product product){
    _controller.addProduct(product);
    emit(_controller.state);
  }

  void remove(Product product){
    _controller.removeProduct(product);
    emit(_controller.state);
  }
}
