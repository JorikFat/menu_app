import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/product.dart';

class CatalogBloc extends Bloc<Product, List<CartProduct>>{
  final CartBloc cart;

  CatalogBloc(this.cart) :super(stubProducts.map(CartProduct.zero).toList());

  void addProduct(Product product){
    cart.add(CartAddProductEvent(product));
  }
}