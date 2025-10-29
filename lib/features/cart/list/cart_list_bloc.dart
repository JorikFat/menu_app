import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/cart/list/cart_list_events.dart';
import 'package:menu_app/features/cart/list/cart_list_states.dart';
import 'package:menu_app/features/product/product.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  final CartInteractor _cart;

  CartListBloc(this._cart) : super(_mapState(_cart.state)) {
    _cart.stream.listen((cartState) => add(CartListUpdateEvent(cartState)));
    //TODO: merge handle
    on<CartListAddProductEvent>(_addProduct);
    on<CartListRemoveProductEvent>(_removeProduct);
    on<CartListUpdateEvent>(_update);
    add(CartListUpdateEvent(_cart.state));
  }

  void _update(
    CartListUpdateEvent event,
    Emitter<CartListState> emit,
  ) {
    emit(_mapState(_cart.state));
  }

  void _addProduct(
    CartListAddProductEvent event,
    Emitter<CartListState> emit,
  ) {
    _cart.add(_model(event.product));
  }

  void _removeProduct(
    CartListRemoveProductEvent event,
    Emitter<CartListState> emit,
  ) {
    _cart.remove(_model(event.product));
  }

  Product _model(ProductCartViewState viewState) =>
      _cart.state.entries.firstWhere((it) => it.key.name == viewState.name).key;
}

CartListState _mapState(Map<Product, int> cartState) => cartState.isEmpty
    ? const CartEmptyState()
    : CartDataState(
        cartState.entries
            .map(
              (entry) => ProductCartViewState.product(
                entry.key,
                count: entry.value,
              ),
            )
            .toList(),
      );
