import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_controller.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';
import 'package:menu_app/features/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartController _controller = CartController();

  static CartProduct toCartProduct(MapEntry<Product, int> pair) =>
    CartProduct.product(pair.key, pair.value);

  CartBloc() : super(const CartEmptyState()) {
    on<CartAddProductEvent>(_addProduct);
    on<CartRemoveProductEvent>(_removeProduct);
  }

  int countOf(Product product) => _controller.countOf(product);

  void _addProduct(
    CartAddProductEvent event,
    Emitter<CartState> emit,
  ) {
    _controller.addProduct(event.product);
    emit(_dataState);
  }

  void _removeProduct(
    CartRemoveProductEvent event,
    Emitter<CartState> emit,
  ) {
    _controller.removeProduct(event.product);
    emit(_dataState);
  }

  CartDataState get _dataState => CartDataState(_controller.state.entries.map(toCartProduct).toList());
}

