import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/cart/cart_interactor_cubit.dart';
import 'package:menu_app/features/cart/cart_product.dart';
@GenerateNiceMocks([MockSpec<CatalogSource>()])
import 'package:menu_app/features/catalog/catalog_controller.dart';
import 'package:menu_app/features/catalog/catalog_interactor_cubit.dart';
import 'package:menu_app/features/catalog/list/catalog_list_state.dart';
import 'package:menu_app/features/product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'catalog_cubit_test.mocks.dart';

void main() {
  group(CatalogInteractorCubit, () {
    late CartInteractorCubit cart;
    late CatalogInteractorCubit catalog;

    const Product prod1 = Product('first', 1);
    const Product prod2 = Product('second', 2);
    const Product prod3 = Product('third', 3);
    final CatalogSource mockSource = MockCatalogSource();
    when(mockSource.fetchProducts()).thenAnswer(
        (_) => Future.delayed(Duration.zero, () => [prod1, prod2, prod3]));

    setUp(() {
      cart = CartInteractorCubit.def();
      catalog =
          CatalogInteractorCubit(CatalogController(mockSource), cart);
    });

    tearDown(() async {
      await Future((){});
      await cart.close();
      await catalog.close();
    });

    test('initial', () {
      expect(catalog.state, isInstanceOf<CatalogLoadState>());
    });

    test('catalog is loaded', () async {
      //GIVEN
      expect(catalog.state, const CatalogLoadState());
      //WHEN
      await Future(() {});
      //THEN
      expect(catalog.state, isInstanceOf<CatalogDataState>());
    });

    test('add first product', () async {
      //GIVEN
      expect(catalog.state, const CatalogLoadState());
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      await Future(() {});
      //THEN
      final products = (catalog.state as CatalogDataState).products;
      expect(products, [
        CartProduct.product(prod1, 1),
        CartProduct.product(prod2),
        CartProduct.product(prod3),
      ]);
    });
    
    test('add first product 3 times', () async {
      //GIVEN
      expect(catalog.state, const CatalogLoadState());
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      await Future(() {});
      //THEN
      final products = (catalog.state as CatalogDataState).products;
      expect(products, [
        CartProduct.product(prod1, 3),
        CartProduct.product(prod2),
        CartProduct.product(prod3),
      ]);
    });
    
    test('add first and second', () async {
      //GIVEN
      expect(catalog.state, const CatalogLoadState());
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      catalog.addProduct(prod2);
      await Future(() {});
      //THEN
      final products = (catalog.state as CatalogDataState).products;
      expect(products, [
        CartProduct.product(prod1, 1),
        CartProduct.product(prod2, 1),
        CartProduct.product(prod3),
      ]);
    });
    
    test('add first product 3 times and second 2 times', () async {
      //GIVEN
      expect(catalog.state, const CatalogLoadState());
      //WHEN
      await Future(() {});
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      catalog.addProduct(prod1);
      catalog.addProduct(prod2);
      catalog.addProduct(prod2);
      await Future(() {});
      //THEN
      final products = (catalog.state as CatalogDataState).products;
      expect(products, [
        CartProduct.product(prod1, 3),
        CartProduct.product(prod2, 2),
        CartProduct.product(prod3),
      ]);
    });
  });
}
