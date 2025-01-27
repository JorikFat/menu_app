import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/catalog/catalog_state.dart';
import 'package:menu_app/features/product.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final CatalogController controller;
  final CartBloc cart;

  CatalogCubit({
    required this.cart,
    required this.controller
  }) :super(const CatalogLoadState()){
    cart.stream.listen(_listenCart);
    controller.init().then((value) => emit(CatalogDataState(value.map(CartProduct.product).toList())));
  }

  void addProduct(Product product){
    cart.add(CartAddProductEvent(product));
  }

  void _listenCart(CartState cartState) {
    final List<Product> products = controller.state;
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