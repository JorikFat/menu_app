import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/product.dart';

class CatalogInteractorCubit extends Cubit<Map<Product, int>> {
  final CartInteractor cart;
  final CatalogController controller;

  CatalogInteractorCubit(this.controller, this.cart) : super({}) {
    cart.listen(_updateCatalog);
    controller
        .init()
        .then((catalog) => emit(_mapCartProducts(catalog, cart.state)));
  }

  void addProduct(Product product) => cart.add(product);

  void _updateCatalog(Map<Product, int> cartProducts) {
    emit(_mapCartProducts(controller.state, cartProducts));
  }

  Map<Product, int> _mapCartProducts(
    List<Product> catalog,
    Map<Product, int> cart,
  ) =>
      Map.fromEntries(catalog.map((it) => MapEntry(it, cart[it] ?? 0)));
}
