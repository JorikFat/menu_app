import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_count_cubit.dart';
import 'package:menu_app/features/product.dart';

Product get stubProduct => const Product('stub', 1);

void main() {

  group(CartCountCubit, () {
    late CartBloc cart;
    late CartCountCubit count;

    setUp(() {
      cart = CartBloc();
      count = CartCountCubit(cart);
    });

    tearDown(() async {
      await cart.close();
      await count.close();
    });

    test('initial count is 0', () {
      expect(count.state, 0);
    });

    test('add 1 product', () async {
      //GIVEN
      expect(count.state, 0);
      //WHEN
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      //THEN
      expect(count.state, 1);
    });

    test('add 3 products', () async {
      //GIVEN
      expect(count.state, 0);
      //WHEN
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      //THEN
      expect(count.state, 3);
    });

    test('remove 1 products', () async {
      //GIVEN
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      expect(count.state, 5);
      //WHEN
      cart.add(CartRemoveProductEvent(stubProduct));
      await Future((){});
      //THEN
      expect(count.state, 4);
    });

    test('remove full products', () async {
      //GIVEN
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      expect(count.state, 3);
      //WHEN
      cart.add(CartRemoveProductEvent(stubProduct));
      cart.add(CartRemoveProductEvent(stubProduct));
      cart.add(CartRemoveProductEvent(stubProduct));
      await Future((){});
      //THEN
      expect(count.state, 0);
    });
  });
}
