import 'package:menu_app/features/cart/cart_controller.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/product.dart';
import 'package:test/test.dart';

void main() {
  late CartController controller;
  late CartInteractor interactor;

  setUp(() {
    controller = CartController();
    interactor = CartInteractor(controller);
  });

  test('initial is empty',(){
    expect(interactor.state, {});
  });

  test('add one product', () async {
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    interactor.add(prod1);
    interactor.add(prod2);
    //THEN
    expect(interactor.state, {prod1: 1, prod2: 1});
  });

  test('add two products', () {
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    interactor.add(prod1);
    interactor.add(prod2);
    //THEN
    expect(interactor.state, {prod1: 1, prod2: 1});
  });

  test('add one product 3 times and second 2 times', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    interactor.add(prod1);
    interactor.add(prod1);
    interactor.add(prod1);
    interactor.add(prod2);
    interactor.add(prod2);
    //THEN
    expect(interactor.state, {prod1: 3, prod2: 2});
  });

  test('remove one product', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    interactor.add(prod1);
    interactor.add(prod1);
    interactor.add(prod2);
    interactor.add(prod2);
    //WHEN
    interactor.remove(prod1);
    //THEN
    expect(interactor.state, {prod1: 1, prod2: 2});
  });

    test('remove all products', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    interactor.add(prod1);
    interactor.add(prod1);
    interactor.add(prod2);
    interactor.add(prod2);
    //WHEN
    interactor.remove(prod1);
    interactor.remove(prod1);
    interactor.remove(prod2);
    interactor.remove(prod2);
    //THEN
    expect(interactor.state, {});
  });
}