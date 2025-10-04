import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/catalog/catalog.dart';
import 'package:menu_app/features/catalog/catalog_interactor.dart';
import 'package:menu_app/features/catalog/data/catalog_stub_source.dart';
import 'package:menu_app/features/catalog/list/catalog_list_bloc.dart';
import 'package:provider/provider.dart';

final catalogProviders = [
  Provider<Catalog>.value(value: Catalog()),
  Provider<CatalogInteractor>(
    create: (context) => CatalogInteractor(
      catalog: context.read<Catalog>(),
      cart: context.read<CartInteractor>(),
      sourse: CatalogStubSource(),
    ),
  ),
  BlocProvider<CatalogListBloc>(
    create: (context) => CatalogListBloc(
      context.read<CatalogInteractor>(),
    ),
  ),
];
