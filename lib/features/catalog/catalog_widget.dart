import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/catalog_bloc.dart';
import 'package:menu_app/features/catalog/catalog_event.dart';
import 'package:menu_app/features/catalog/catalog_state.dart';
import 'package:menu_app/features/product.dart';

class CatalogWidget extends StatelessWidget {
  final CatalogBloc bloc;

  const CatalogWidget(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: bloc,
      builder: (context, state) => switch (state) {
        CatalogLoadState() => const _Load(),
        CatalogDataState() => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final CartProduct product = state.products[index];
              final _Product widget = _Product(product);
              return InkWell(
                onTap: () => bloc.add(CatalogAddProductEvent(product)),
                child: product.count == 0
                    ? widget
                    : Badge(
                        label: Text(product.count.toString()),
                        child: widget,
                      ),
              );
            },
          ),
      },
    );
  }
}

class _Load extends StatelessWidget {
  const _Load();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Product extends StatelessWidget {
  final Product product;

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
          ],
        ),
      ),
    );
  }
}
