import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/product/product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
@GenerateNiceMocks([MockSpec<Cart>()])
import 'package:menu_app/features/cart/business/cart.dart';

import 'cart_interactor_test.mocks.dart';

void main() {
  late Cart cart;
  late CartInteractor interactor;

  setUp(() {
    cart = MockCart();
    interactor = CartInteractor(cart);
  });

  test('initial is empty', () {
    expect(interactor.state, {});
    verifyNever(cart.addProduct(TestProduct()));
  });

  test('add one product', () async {
    when(cart.state).thenReturn({TestProduct(): 1});
    expectLater(interactor.stream, emits({TestProduct(): 1}));
    interactor.add(TestProduct());
    verify(cart.addProduct(TestProduct()));
  });

  test('add two products', () {
    when(cart.state).thenReturnInOrder([
      {TestProduct(1): 1},
      {TestProduct(2): 2},
    ]);
    expectLater(
        interactor.stream,
        emitsInOrder([
          {TestProduct(1): 1},
          {TestProduct(2): 2},
        ]));
    interactor.add(TestProduct(1));
    interactor.add(TestProduct(2));
    verify(cart.addProduct(TestProduct(1)));
    verify(cart.addProduct(TestProduct(2)));
  });

  test('remove one product', () {
    when(cart.state).thenReturn({TestProduct(): 1});
    expectLater(interactor.stream, emits({TestProduct(): 1}));
    interactor.remove(TestProduct());
    verify(cart.removeProduct(TestProduct()));
  });

  test('clear', () {
    when(cart.state).thenReturn({TestProduct(): 1});
    expectLater(interactor.stream, emits({TestProduct(): 1}));
    interactor.purchase();
    verify(cart.clear());
  });
}

class TestProduct extends Product {
  TestProduct([int index = 0]) : super('$index', index);
}