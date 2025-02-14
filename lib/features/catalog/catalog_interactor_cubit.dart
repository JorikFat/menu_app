import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor_cubit.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/product.dart';

class CatalogInteractorCubit extends Cubit<List<CartProduct>>{
  final CartInteractorCubit cart;
  final CatalogController controller;

  CatalogInteractorCubit(this.controller, this.cart) :super([]){
    cart.stream.listen(_updateCatalog);
    controller.init().then((catalog) => emit(_mapCartProducts(catalog, cart.state)));
  }

  void addProduct(Product product) => cart.add(product);

  void _updateCatalog(Map<Product, int> cartProducts) {
    emit(_mapCartProducts(controller.state, cartProducts));
  }

  List<CartProduct> _mapCartProducts(
    List<Product> catalog,
    Map<Product, int> cart,
  ) =>
      catalog
          .map((it) => CartProduct(cart[it] ?? 0, it.name, it.price))
          .toList();

}