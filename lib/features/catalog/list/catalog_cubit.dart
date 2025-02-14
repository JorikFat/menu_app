import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor_cubit.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/catalog/list/catalog_state.dart';
import 'package:menu_app/features/product.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final CatalogController controller;
  final CartInteractorCubit cart;

  CatalogCubit({
    required this.cart,
    required this.controller,
  }) : super(const CatalogLoadState()) {
    cart.stream.listen(_updateCatalog);
    controller.init().then((catalog) =>
        emit(CatalogDataState(_mapCartProducts(catalog, cart.state))));
  }

  void addProduct(Product product) => cart.add(product);

  void _updateCatalog(Map<Product, int> cartProducts) {
    emit(CatalogDataState(_mapCartProducts(controller.state, cartProducts)));
  }

  List<CartProduct> _mapCartProducts(
    List<Product> catalog,
    Map<Product, int> cart,
  ) =>
      catalog
          .map((it) => CartProduct(cart[it] ?? 0, it.name, it.price))
          .toList();
}
