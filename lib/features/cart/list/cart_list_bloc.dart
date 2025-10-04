import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/cart/list/cart_list_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/list/cart_list_states.dart';
import 'package:menu_app/features/product/product.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  final CartInteractor _cart;

  CartListBloc(this._cart) : super(_toCartListState(_cart.state)) {
    on<CartListAddProductEvent>(_addProduct);
    on<CartListRemoveProductEvent>(_removeProduct);
    on<CartListUpdateEvent>(_update);
    _cart.listen((cartState) => add(CartListUpdateEvent(cartState)));
  }

  void _update(
    CartListUpdateEvent event,
    Emitter<CartListState> emit,
  ) {
    emit(_toCartListState(event.cartState));
  }

  void _addProduct(
    CartListAddProductEvent event,
    Emitter<CartListState> emit,
  ) {
    _cart.add(event.product.product);
  }

  void _removeProduct(
    CartListRemoveProductEvent event,
    Emitter<CartListState> emit,
  ) {
    _cart.remove(event.product.product);
  }
}

CartListState _toCartListState(Map<Product, int> map) => map.isEmpty
    ? const CartEmptyState()
    : CartDataState(map.entries
        .map((entry) => CartProduct(entry.value, entry.key))
        .toList());
