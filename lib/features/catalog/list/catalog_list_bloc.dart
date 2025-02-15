import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/catalog_interactor_cubit.dart';
import 'package:menu_app/features/catalog/list/catalog_list_event.dart';
import 'package:menu_app/features/catalog/list/catalog_list_state.dart';
import 'package:menu_app/features/product.dart';

class CatalogListBloc extends Bloc<CatalogListEvent, CatalogListState> {
  final CatalogInteractorCubit interactor;

  CatalogListBloc(this.interactor) : super(const CatalogLoadState()) {
    interactor.stream.listen(
        (catalog) => add(CatalogListUpdateEvent(_mapCartProducts(catalog))));
    on<CatalogListUpdateEvent>(_updateCatalog);
    on<CatalogListAddEvent>(_addProduct);
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
    interactor.addProduct(event.product);
  }

  List<CartProduct> _mapCartProducts(Map<Product, int> cart) => cart.entries
      .map((it) => CartProduct(it.value, it.key.name, it.key.price))
      .toList();
}
