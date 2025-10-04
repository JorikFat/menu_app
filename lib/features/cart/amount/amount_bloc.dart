import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/amount/amount_events.dart';
import 'package:menu_app/features/cart/amount/amount_state.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/product/product.dart';

class AmountBloc extends Bloc<AmountEvent, AmountState> {
  final CartInteractor _cart;
  AmountBloc(this._cart) : super(const AmountState()) {
    on<AmountPurchaseEvent>(_purchase);
    on<AmountChangeEvent>(_update);
    _cart.listen((order) => add(AmountChangeEvent(order)));
  }

  void _purchase(
    AmountPurchaseEvent event,
    Emitter<AmountState> emit,
  ) {
    _cart.purchase();
  }

  void _update(
    AmountChangeEvent event,
    Emitter<AmountState> emit,
  ) {
    emit(AmountState("Общая сумма заказа: ${_orderAmount(event.order)}"));
  }

  int _orderAmount(Map<Product, int> order) => order.entries
      .map((entry) => entry.key.price * entry.value)
      .reduce((sum, element) => sum + element);
}
