import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_states.dart';

class CartCountCubit extends Cubit<int> {
  final CartBloc _cart;

  CartCountCubit(this._cart) : super(0) {
    _cart.stream.listen((cartState) {
      switch (cartState) {
        case CartEmptyState():
          emit(0);
          break;
        case CartDataState():
          emit(_cart.count);
          break;
      }
    });
  }
}
