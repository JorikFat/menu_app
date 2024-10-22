import 'package:menu_app/features/cart/cart_product.dart';

sealed class CartState {
  const CartState();
}

class CartEmptyState extends CartState{
  const CartEmptyState();
}

class CartDataState extends CartState {
  final List<CartProduct> products;

  CartDataState(this.products);
  CartDataState.single(CartProduct product) :this([product]);
}