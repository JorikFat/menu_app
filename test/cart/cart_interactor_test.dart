import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/cart_controller.dart';
import 'package:menu_app/features/cart/cart_interactor_cubit.dart';
import 'package:menu_app/features/product.dart';

void main() {
  late CartController controller;
  late CartInteractorCubit cubit;

  setUp(() {
    controller = CartController();
    cubit = CartInteractorCubit(controller);
  });

  tearDown(() async {
    await cubit.close();
  });

  test('initial is empty cart', () {
    expect(cubit.state, {});
  });

  test('add one product', () async {
    //GIVEN
    const Product product = Product('stub', 1);
    //WHEN
    cubit.add(product);
    // await Future((){});
    //THEN
    expect(cubit.state, {product: 1});
  });

  test('add two products', () {
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    cubit.add(prod1);
    cubit.add(prod2);
    //THEN
    expect(cubit.state, {prod1: 1, prod2: 1});
  });

  test('add one product 3 times and second 2 times', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    cubit.add(prod1);
    cubit.add(prod1);
    cubit.add(prod1);
    cubit.add(prod2);
    cubit.add(prod2);
    //THEN
    expect(cubit.state, {prod1: 3, prod2: 2});
  });

  test('remove one product', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    cubit.add(prod1);
    cubit.add(prod1);
    cubit.add(prod2);
    cubit.add(prod2);
    //WHEN
    cubit.remove(prod1);
    //THEN
    expect(cubit.state, {prod1: 1, prod2: 2});
  });

  test('remove all products', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    cubit.add(prod1);
    cubit.add(prod1);
    cubit.add(prod2);
    cubit.add(prod2);
    //WHEN
    cubit.remove(prod1);
    cubit.remove(prod1);
    cubit.remove(prod2);
    cubit.remove(prod2);
    //THEN
    expect(cubit.state, {});
  });
}
