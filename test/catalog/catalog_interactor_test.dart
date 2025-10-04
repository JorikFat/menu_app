import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/cart.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
@GenerateNiceMocks([MockSpec<CatalogSource>()])
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/catalog/catalog_interactor.dart';
import 'package:menu_app/features/product/product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'catalog_interactor_test.mocks.dart';


void main() {
  group(CatalogInteractor, () {
    late CartInteractor cart;
    late CatalogInteractor catalog;

    const Product prod1 = Product('first', 1);
    const Product prod2 = Product('second', 2);
    const Product prod3 = Product('third', 3);
    final CatalogSource mockSource = MockCatalogSource();
    when(mockSource.fetchProducts()).thenAnswer(
        (_) => Future.delayed(Duration.zero, () => [prod1, prod2, prod3]));

    setUp(() {
      cart = CartInteractor(Cart());
      catalog = CatalogInteractor(CatalogController(mockSource), cart);
    });

    test('initial', () {
      expect(catalog.state, {});
    });

    test('catalog is loaded', () async {
      //GIVEN
      expect(catalog.state, {});
      //WHEN
      await Future(() {});
      //THEN
      expect(catalog.state, {prod1: 0, prod2: 0, prod3: 0});
    });

    test('add first product', () async {
      //GIVEN
      expect(catalog.state, {});
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      await Future(() {});
      //THEN
      expect(catalog.state, {prod1: 1, prod2: 0, prod3: 0});
    });

    test('add first product 3 times', () async {
      //GIVEN
      expect(catalog.state, {});
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      await Future(() {});
      //THEN
      expect(catalog.state, {prod1: 3, prod2: 0, prod3: 0});
    });

    test('add first and second', () async {
      //GIVEN
      expect(catalog.state, {});
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      catalog.addProduct(prod2);
      await Future(() {});
      //THEN
      expect(catalog.state, {prod1: 1, prod2: 1, prod3: 0});
    });

    test('add first product 3 times and second 2 times', () async {
      //GIVEN
      expect(catalog.state, {});
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      catalog.addProduct(prod2);
      catalog.addProduct(prod2);
      await Future(() {});
      //THEN
      expect(catalog.state, {prod1: 3, prod2: 2, prod3: 0}
      );
    });
  });
}
