import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/catalog_bloc.dart';
import 'package:menu_app/features/catalog/catalog_event.dart';
import 'package:menu_app/features/catalog/catalog_state.dart';

class CatalogWidget extends StatelessWidget {
  final CatalogBloc bloc;

  const CatalogWidget(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: bloc,
      builder: (context, state) => switch(state){
        CatalogLoadState() => const _Load(),
        CatalogDataState() => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.products.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) => InkWell(
            onTap: () => bloc.add(CatalogAddProductEvent(state.products[index])),
            child: _Product(state.products[index]),
          ),
        ),
      }
    );
  
  }
}

class _Load extends StatelessWidget {

  const _Load();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(),);
  }

}

class _Product extends StatelessWidget {
  final CartProduct product;

  const _Product(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(child: Text(product.name)),
            Text(product.price.toString()),
            if (product.count > 0)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(product.count.toString()),
              ),
          ],
        ),
      ),
    );
  }
}
