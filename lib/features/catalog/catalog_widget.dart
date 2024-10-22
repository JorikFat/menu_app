import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/catalog/catalog_bloc.dart';
import 'package:menu_app/features/catalog/product.dart';

class CatalogWidget extends StatelessWidget {
  final CatalogBloc bloc;

  const CatalogWidget(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, List<Product>>(
      bloc: bloc,
      builder: (context, state) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: 8,
        ),
        itemBuilder: (context, index) => _Product(state[index]),
      ),
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
            Text(product.price.toString())
          ],
        ),
      ),
    );
  }
}
