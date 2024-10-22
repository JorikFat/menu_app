import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';
import 'package:menu_app/features/catalog/catalog_event.dart';
import 'package:menu_app/features/catalog/catalog_provider.dart';
import 'package:menu_app/features/catalog/catalog_state.dart';

class CatalogBloc extends Bloc<CatalogAddProductEvent, CatalogState> {
  final CartBloc cart;
  final CatalogProvider provider = CatalogProvider();

  CatalogBloc(this.cart) : super(const CatalogLoadState()) {
    on<CatalogAddProductEvent>((event, _) => cart.add(CartAddProductEvent(event.product)));
    cart.stream.listen(_listenCart);
    provider.fetchProducts().then(
          (value) =>
              emit(CatalogDataState(value.map(CartProduct.zero).toList())),
        );
  }

  void _listenCart(CartState cartState) {
    if (state is CatalogLoadState) return;
    state as CatalogDataState;
    final products = (state as CatalogDataState).products;
    switch (cartState) {
      case CartEmptyState():
        emit(CatalogDataState(products.map(CartProduct.zero).toList()));
        break;
      case CartDataState():
        emit(CatalogDataState(
            products.map((it) => _map(it, cartState.products)).toList()));
        break;
    }
  }

  CartProduct _map(CartProduct product, List<CartProduct> products) {
    return products.contains(product)
        ? products.firstWhere((it) => it.name == product.name)
        : CartProduct.zero(product);
  }
}
