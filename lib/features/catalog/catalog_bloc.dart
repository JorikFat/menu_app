import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/catalog/catalog_event.dart';
import 'package:menu_app/features/catalog/catalog_state.dart';

//TODO: replace by Cubit
class CatalogBloc extends Bloc<CatalogAddProductEvent, CatalogState> {
  final CatalogController _controller = CatalogController();

  final CartBloc cart;

  CatalogBloc(this.cart) : super(const CatalogLoadState()) {
    on<CatalogAddProductEvent>((event, _) => cart.add(CartAddProductEvent(event.product)));
    cart.stream.listen(_listenCart);
    _controller.init().then((value) => emit(CatalogDataState(value.map(CartProduct.product).toList())));
  }

  void _listenCart(CartState cartState) {
    final products = (state as CatalogDataState).products;
    switch (cartState) {
      case CartEmptyState():
        emit(CatalogDataState(products.map(CartProduct.product).toList()));
        break;
      case CartDataState():
        emit(CatalogDataState(
            products.map((it) => CartProduct.product(it, cart.countOf(it))).toList()));
        break;
    }
  }
}
