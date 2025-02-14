import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor_cubit.dart';
import 'package:menu_app/features/product.dart';

class CartCountCubit extends Cubit<int> {
  final CartInteractorCubit _cart;

  CartCountCubit(this._cart) : super(0) {
    _cart.stream.listen((cartState) {
      emit(_count(cartState));
    });
  }

  int _count(Map<Product, int> cartState) => cartState.isEmpty
      ? 0
      : cartState.entries
          .map((it) => it.value)
          .reduce((sum, count) => sum + count);
}
