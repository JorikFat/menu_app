import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartEmptyState()) {
    on<CartAddProductEvent>(_addProduct);
    on<CartRemoveProductEvent>(_removeProduct);
  }

  void _addProduct(
    CartAddProductEvent event,
    Emitter<CartState> emit,
  ) {
    if(state is CartEmptyState){
      emit(CartDataState.single(CartProduct.product(event.product)));
      return;
    }
    final products = (state as CartDataState).products;
    if(!products.contains(event.product)){
      emit(CartDataState(products..add(CartProduct.product(event.product))));
    } else {
      final cartProduct = products.firstWhere((it) => it.name == event.product.name);
      final productIndex = products.indexOf(cartProduct);
      emit(CartDataState([...products..[productIndex] = CartProduct.product(event.product, cartProduct.count + 1)]));
    }
  }

  void _removeProduct(
    CartRemoveProductEvent event,
    Emitter<CartState> emit,
  ) {
    final products = (state as CartDataState).products;
    final cartProduct = products.firstWhere((it) => it.name == event.product.name);
    final productIndex = products.indexOf(cartProduct);
    final newProduct = CartProduct.product(event.product, cartProduct.count - 1);
    if(newProduct.count == 0){
      final updatedProducts = [...products..removeAt(productIndex)];
      emit(updatedProducts.isEmpty ? const CartEmptyState() : CartDataState(updatedProducts) );
    } else {
      emit(CartDataState([...products..[productIndex] = newProduct]));
    }
  }
}

