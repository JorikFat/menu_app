import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/cart.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/cart/list/cart_list_bloc.dart';
import 'package:menu_app/features/cart/list/cart_list_states.dart';
import 'package:menu_app/features/product/product.dart';

Product get stubProduct => const Product('stub', 1);

void main() {
  group(CartListBloc, () {
    late CartInteractor cart;
    late CartListBloc bloc;

    setUp(() {
      cart = CartInteractor(Cart());
      bloc = CartListBloc(cart);
    });

    tearDown(() async {
      await Future(() {});
      await bloc.close();
    });

    test('initial count is empty', () {
      expect(bloc.state, const CartEmptyState());
    });

    test('add 1 product', () async {
      //GIVEN
      expect(bloc.state, const CartEmptyState());
      //WHEN
      cart.add(stubProduct);
      await Future(() {});
      //THEN
      expect(
        bloc.state,
        CartDataState([ProductCartViewState.product(stubProduct, count: 1)]),
      );
    });

    test('add 3 products', () async {
      //GIVEN
      expect(bloc.state, const CartEmptyState());
      //WHEN
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      await Future(() {});
      //THEN
      expect(
        bloc.state,
        CartDataState([ProductCartViewState.product(stubProduct, count: 3)]),
      );
    });

    test('remove 1 products', () async {
      //GIVEN
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      await Future(() {});
      CartDataState(
        [ProductCartViewState.product(stubProduct, count: 5)],
      );
      //WHEN
      cart.remove(stubProduct);
      await Future(() {});
      //THEN
      expect(
        bloc.state,
        CartDataState([ProductCartViewState.product(stubProduct, count: 4)]),
      );
    });

    test('remove full products', () async {
      //GIVEN
      cart.add(stubProduct);
      cart.add(stubProduct);
      cart.add(stubProduct);
      await Future(() {});
      expect(
        bloc.state,
        CartDataState(
          [ProductCartViewState.product(stubProduct, count: 3)],
        ),
      );
      //WHEN
      cart.remove(stubProduct);
      cart.remove(stubProduct);
      cart.remove(stubProduct);
      await Future(() {});
      //THEN
      expect(bloc.state, const CartEmptyState());
    });
  });
}
