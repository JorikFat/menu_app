import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/catalog_event.dart';
import 'package:menu_app/features/catalog/product.dart';

class CatalogBloc extends Bloc<CatalogAddProductEvent, List<CartProduct>> {
  final CartBloc cart;

  CatalogBloc(this.cart) : super(stubProducts.map(CartProduct.zero).toList()) {
    on<CatalogAddProductEvent>(_addProduct);
  }

  void _addProduct(
    CatalogAddProductEvent event,
    Emitter<List<CartProduct>> emit,
  ) {
    cart.add(CartAddProductEvent(event.product));
  }
}
