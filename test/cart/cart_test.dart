import 'package:menu_app/features/cart/cart.dart';
import 'package:menu_app/features/product/product.dart';
import 'package:test/test.dart';

void main() {
  late Cart cart;

  setUp(() => cart = Cart());

  test('initial is empty cart', () {
    expect(cart.state, {});
  });

  test('add one product', () {
    //GIVEN
    const Product product = Product('stub', 1);
    //WHEN
    cart.addProduct(product);
    //THEN
    expect(cart.state, {product: 1});
  });

  test('add two products', () {
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    cart.addProduct(prod1);
    cart.addProduct(prod2);
    //THEN
    expect(cart.state, {prod1: 1, prod2: 1});
  });

  test('add one product 3 times and second 2 times', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    //WHEN
    cart.addProduct(prod1);
    cart.addProduct(prod1);
    cart.addProduct(prod1);
    cart.addProduct(prod2);
    cart.addProduct(prod2);
    //THEN
    expect(cart.state, {prod1: 3, prod2: 2});
  });

  test('remove one product', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    cart.addProduct(prod1);
    cart.addProduct(prod1);
    cart.addProduct(prod2);
    cart.addProduct(prod2);
    //WHEN
    cart.removeProduct(prod1);
    //THEN
    expect(cart.state, {prod1: 1, prod2: 2});
  });

  test('remove all products', (){
    //GIVEN
    const Product prod1 = Product('stub1', 1);
    const Product prod2 = Product('stub2', 2);
    cart.addProduct(prod1);
    cart.addProduct(prod1);
    cart.addProduct(prod2);
    cart.addProduct(prod2);
    //WHEN
    cart.removeProduct(prod1);
    cart.removeProduct(prod1);
    cart.removeProduct(prod2);
    cart.removeProduct(prod2);
    //THEN
    expect(cart.state, {});
  });
}
