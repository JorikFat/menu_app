import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/extensions.dart';
import 'package:menu_app/features/catalog/catalog_interactor.dart';
import 'package:menu_app/features/catalog/list/catalog_list_event.dart';
import 'package:menu_app/features/catalog/list/catalog_list_state.dart';
import 'package:menu_app/features/product/product.dart';

class CatalogListBloc extends Bloc<CatalogListEvent, CatalogListState> {
  final CatalogInteractor interactor;

  CatalogListBloc(this.interactor)
      : super(
          interactor.state.isEmpty
              ? const CatalogListState.load()
              : CatalogListState.data(_mapCartProducts(interactor.state)),
        ) {
    on<CatalogListEvent>(
      (event, emit) => switch (event) {
        CatalogListUpdateEvent() => emit(CatalogListState.data(event.products)),
        CatalogListAddEvent() => interactor.addProduct(event.product),
      },
    );
    interactor.stream.listen(
        (catalog) => add(CatalogListEvent.update(_mapCartProducts(catalog))));
  }

  @override
  Future<void> close() async {
    await interactor.close();
    return super.close();
  }
}

Map<Product, int?> _mapCartProducts(Map<Product, int> cart) => cart.map(
    (key, value) => MapEntry<Product, int?>(key, value.takeIf((it) => it > 0)));
