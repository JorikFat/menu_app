import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/extensions.dart';
import 'package:menu_app/features/catalog/catalog_interactor.dart';
import 'package:menu_app/features/catalog/list/catalog_list_bloc.dart';
import 'package:menu_app/features/catalog/list/catalog_list_event.dart';
import 'package:menu_app/features/catalog/list/catalog_list_state.dart';
import 'package:menu_app/features/product/product.dart';

BlocProvider catalogBlocProvider([Widget? child]) =>
    BlocProvider<CatalogListBloc>(
      create: (context) => CatalogListBloc(
        context.read<CatalogInteractor>(),
      ),
      child: child,
    );

class CatalogWidget extends StatelessWidget {
  const CatalogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogListBloc, CatalogListState>(
      builder: (context, state) => switch (state) {
        CatalogLoadState() => const CatalogLoadingWidget(),
        CatalogDataState() => CatalogListWidget(
            products: state.products,
            onTap: (product) => context
                .read<CatalogListBloc>()
                .add(CatalogListAddEvent(product)),
          ),
      },
    );
  }
}

class CatalogListWidget extends StatelessWidget {
  final Map<Product, int?> products;
  final void Function(Product product) onTap;

  const CatalogListWidget({
    required this.products,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final MapEntry<Product, int?> product = products.entries.toList()[index];
        return InkWell(
          onTap: () => onTap(product.key),
          child: _Product(product.key).badge(product.value),
        );
      },
    );
  }
}

class CatalogLoadingWidget extends StatelessWidget {
  const CatalogLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Product extends StatelessWidget {
  final Product product;

  const _Product(this.product);

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
