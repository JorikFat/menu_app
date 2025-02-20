import 'package:menu_app/features/cart/cart_controller.dart';
import 'package:menu_app/features/product.dart';
import 'package:test/test.dart';

void main() {
  late CartController controller;

  setUp(() => controller = CartController());

  test('initial is empty cart', () {
    expect(controller.state, {});
  });

  test('add one product', () {
    //GIVEN
    const Product product = Product('stub', 1);
    //WHEN
    controller.addProduct(product);
    //THEN
    expect(controller.state, {product: 1});
  });

  test('add two products', () {
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    controller.addProduct(prod1);
    controller.addProduct(prod2);
    //THEN
    expect(controller.state, {prod1: 1, prod2: 1});
  });

  test('add one product 3 times and second 2 times', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    controller.addProduct(prod1);
    controller.addProduct(prod1);
    controller.addProduct(prod1);
    controller.addProduct(prod2);
    controller.addProduct(prod2);
    //THEN
    expect(controller.state, {prod1: 3, prod2: 2});
  });

  test('remove one product', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    controller.addProduct(prod1);
    controller.addProduct(prod1);
    controller.addProduct(prod2);
    controller.addProduct(prod2);
    //WHEN
    controller.removeProduct(prod1);
    //THEN
    expect(controller.state, {prod1: 1, prod2: 2});
  });

  test('remove all products', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    controller.addProduct(prod1);
    controller.addProduct(prod1);
    controller.addProduct(prod2);
    controller.addProduct(prod2);
    //WHEN
    controller.removeProduct(prod1);
    controller.removeProduct(prod1);
    controller.removeProduct(prod2);
    controller.removeProduct(prod2);
    //THEN
    expect(controller.state, {});
  });
}
