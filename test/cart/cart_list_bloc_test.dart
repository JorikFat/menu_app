import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/cart_cubit.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/count/cart_count_cubit.dart';
import 'package:menu_app/features/cart/list/cart_list_bloc.dart';
import 'package:menu_app/features/cart/list/cart_list_states.dart';
import 'package:menu_app/features/product.dart';

Product get stubProduct => const Product('stub', 1);

void main() {

  group(CartListBloc, () {
    late CartCubit cart;
    late CartListBloc bloc;

    setUp(() {
      cart = CartCubit.def();
      bloc = CartListBloc(cart);
    });

    tearDown(() async {
      await cart.close();
      await bloc.close();
    });

    // test('initial count is 0', () {
    //   expect(bloc.state, const CartEmptyState());
    // });

    test('add 1 product', () async {
      //GIVEN
      // expect(count.state, 0);
      expect(bloc.state, const CartEmptyState());
      // expect(bloc.state, const CartDataState([]));
      //WHEN
      cart.add(stubProduct);
      await Future((){});
      //THEN
      // expect((bloc.state as CartDataState).list, [CartProduct.product(stubProduct, 1)]);
      expect(bloc.state, CartDataState([CartProduct.product(stubProduct, 1)]));
    });

    // test('add 3 products', () async {
    //   //GIVEN
    //   expect(count.state, 0);
    //   //WHEN
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   await Future((){});
    //   //THEN
    //   expect(count.state, 3);
    // });

    // test('remove 1 products', () async {
    //   //GIVEN
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   await Future((){});
    //   expect(count.state, 5);
    //   //WHEN
    //   cart.remove(stubProduct);
    //   await Future((){});
    //   //THEN
    //   expect(count.state, 4);
    // });

    // test('remove full products', () async {
    //   //GIVEN
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   cart.add(stubProduct);
    //   await Future((){});
    //   expect(count.state, 3);
    //   //WHEN
    //   cart.remove(stubProduct);
    //   cart.remove(stubProduct);
    //   cart.remove(stubProduct);
    //   await Future((){});
    //   //THEN
    //   expect(count.state, 0);
    // });
  });
}
