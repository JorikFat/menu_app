import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/business/cart.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/cart/count/cart_count_cubit.dart';
import 'package:menu_app/features/product/product.dart';

Product get stubProduct => const Product('stub', 1);

void main() {

  group(CartCountCubit, () {
    late CartInteractor cart;
    late CartCountCubit count;

    setUp(() {
      cart = CartInteractor(Cart());
      count = CartCountCubit(cart);
    });

    tearDown(() async {
      await count.close();
    });

    test('initial count is 0', () {
      expect(count.state, 0);
    });

    test('add 1 product', () async {
      //GIVEN
      expect(count.state, 0);
      //WHEN
      cart.add(stubProduct);
      await Future((){});
      //THEN
      expect(count.state, 1);
    });

    test('add 3 products', () async {
      //GIVEN
      expect(count.state, 0);
      //WHEN
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      await Future((){});
      //THEN
      expect(count.state, 3);
    });

    test('remove 1 products', () async {
      //GIVEN
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      await Future((){});
      expect(count.state, 5);
      //WHEN
      cart.remove(stubProduct);
      await Future((){});
      //THEN
      expect(count.state, 4);
    });

    test('remove full products', () async {
      //GIVEN
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      await Future((){});
      expect(count.state, 3);
      //WHEN
      cart.remove(stubProduct);
      cart.remove(stubProduct);
      cart.remove(stubProduct);
      await Future((){});
      //THEN
      expect(count.state, 0);
    });
  });
}
