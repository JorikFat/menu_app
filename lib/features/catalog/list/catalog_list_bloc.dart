import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/extensions.dart';
import 'package:menu_app/features/cart/cart_product.dart';
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
        CatalogListUpdateEvent() => _updateCatalog(event, emit),
        CatalogListAddEvent() => _addProduct(event, emit),
      },
    );
    interactor.stream.listen(
        (catalog) => add(CatalogListUpdateEvent(_mapCartProducts(catalog))));
  }

  @override
  Future<void> close() async {
    await interactor.close();
    return super.close();
  }

  void _updateCatalog(
    CatalogListUpdateEvent event,
    Emitter<CatalogListState> emit,
  ) {
    emit(CatalogDataState(event.products));
  }

  void _addProduct(
    CatalogListAddEvent event,
    Emitter<CatalogListState> emit,
  ) {
    interactor.addProduct(event.product.product);
  }
}

List<CartProduct> _mapCartProducts(Map<Product, int> cart) => cart.entries
    .map((entry) => CartProduct(entry.value.takeIf((it) => it > 0), entry.key))
    .toList();
