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
    on<CatalogAddProductEvent>(_addProduct);
    cart.stream.listen(_listenCart);
    provider.fetchProducts().then((value) => emit(CatalogDataState(value.map(CartProduct.zero).toList())));
  }

  void _listenCart(CartState cartState){
    if(state is CatalogLoadState) return;
    state as CatalogDataState;
    final products = (state as CatalogDataState).products;
    switch(cartState){
      case CartEmptyState(): 
        emit(CatalogDataState(products.map(CartProduct.zero).toList()));
        break;
      case CartDataState():
        emit(CatalogDataState(products.map((it) => CartProduct.product(it, _productCount(it, cartState))).toList()));
        break;
    }
  }

  void _addProduct(
    CatalogAddProductEvent event,
    Emitter<CatalogState> emit,
  ) {
    cart.add(CartAddProductEvent(event.product));
  }

  int _productCount(CartProduct product, CartDataState cart){
    final contains = cart.products.contains(product);
    if (contains){
      final cartProduct = cart.products.firstWhere((it) => it.name == product.name);
      final index = cart.products.indexOf(cartProduct);
      return cart.products[index].count;
    } else {
      return 0;
    }
  }
}
