import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_cubit.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';
import 'package:menu_app/features/product.dart';

class CartProductsPresenterBloc extends Bloc<CartEvent, CartState> {
  final CartCubit _cart;

  CartProductsPresenterBloc(this._cart) : super(_toCartState(_cart.state)) {
    on<CartAddProductEvent>(_addProduct);
    on<CartRemoveProductEvent>(_removeProduct);
  }

  void _addProduct(
    CartAddProductEvent event,
    Emitter<CartState> emit,
  ) {
    _cart.add(event.product);
  }

  void _removeProduct(
    CartRemoveProductEvent event,
    Emitter<CartState> emit,
  ) {
    _cart.remove(event.product);
  }
}

CartState _toCartState(Map<Product, int> map) => map.isEmpty
    ? const CartEmptyState()
    : CartDataState(map.entries
        .map((entry) =>
            CartProduct(entry.value, entry.key.name, entry.key.price))
        .toList());
