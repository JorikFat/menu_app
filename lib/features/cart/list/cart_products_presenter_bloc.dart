import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_cubit.dart';
import 'package:menu_app/features/cart/list/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/list/cart_states.dart';
import 'package:menu_app/features/product.dart';

class CartProductsPresenterBloc extends Bloc<CartEvent, CartState> {
  final CartCubit _cart;

  CartProductsPresenterBloc(this._cart) : super(_toCartState(_cart.state)) {
    _cart.stream.listen((cartState) => add(CartUpdateEvent(cartState)));
    on<CartAddProductEvent>(_addProduct);
    on<CartRemoveProductEvent>(_removeProduct);
    on<CartUpdateEvent>(_update);
  }

  void _update(
    CartUpdateEvent event,
    Emitter<CartState> emit,
  ) { 
    emit(_toCartState(event.cartState));
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
