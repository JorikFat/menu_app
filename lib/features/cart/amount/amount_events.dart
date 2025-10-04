import 'package:menu_app/features/product/product.dart';

sealed class AmountEvent {
  const AmountEvent();
}

class AmountPurchaseEvent extends AmountEvent {
  const AmountPurchaseEvent() :super();
}

class AmountChangeEvent extends AmountEvent {
  final Map<Product, int> order;

  const AmountChangeEvent(this.order);
}