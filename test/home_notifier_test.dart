import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/product.dart';
import 'package:menu_app/home_notifier.dart';

Product get stubProduct => const Product('stub', 1);

void main() {

  group(HomeNotifier, () {
    late CartBloc cart;
    late HomeNotifier homeNotifier;

    setUp(() {
      cart = CartBloc();
      homeNotifier = HomeNotifier(cart);
    });

    tearDown(() async {
      await cart.close();
    });

    test('initial count is 0', () {
      expect(homeNotifier.value, 0);
    });

    test('add 1 product', () async {
      //GIVEN
      expect(homeNotifier.value, 0);
      //WHEN
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      //THEN
      expect(homeNotifier.value, 1);
    });

    test('add 3 products', () async {
      //GIVEN
      expect(homeNotifier.value, 0);
      //WHEN
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      //THEN
      expect(homeNotifier.value, 3);
    });

    test('remove 1 products', () async {
      //GIVEN
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      expect(homeNotifier.value, 5);
      //WHEN
      cart.add(CartRemoveProductEvent(stubProduct));
      await Future((){});
      //THEN
      expect(homeNotifier.value, 4);
    });

    test('remove full products', () async {
      //GIVEN
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      cart.add(CartAddProductEvent(stubProduct));
      await Future((){});
      expect(homeNotifier.value, 3);
      //WHEN
      cart.add(CartRemoveProductEvent(stubProduct));
      cart.add(CartRemoveProductEvent(stubProduct));
      cart.add(CartRemoveProductEvent(stubProduct));
      await Future((){});
      //THEN
      await expectLater(homeNotifier.value, 0);
    });
  });
}
