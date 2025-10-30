import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/product/product.dart';

class CartCountCubit extends Cubit<int?> {
  final CartInteractor _cart;

  CartCountCubit(this._cart) : super(null) {
    _cart.stream.listen((cartState) => emit(_count(cartState)));
  }

  int? _count(Map<Product, int> cartState) => cartState.isEmpty
      ? null
      : cartState.entries
          .map((it) => it.value)
          .reduce((sum, count) => sum + count);
}
