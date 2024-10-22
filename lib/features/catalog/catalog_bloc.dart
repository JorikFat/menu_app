import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/catalog/product.dart';

class CatalogBloc extends Bloc<Product, List<Product>>{
  CatalogBloc() :super(stubProducts);
}