import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/catalog_bloc.dart';
import 'package:menu_app/features/catalog/catalog_event.dart';

class CatalogWidget extends StatelessWidget {
  final CatalogBloc bloc;

  const CatalogWidget(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, List<CartProduct>>(
      bloc: bloc,
      builder: (context, state) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) => InkWell(
          onTap: () => bloc.add(CatalogAddProductEvent(state[index])),
          child: _Product(state[index]),
        ),
      ),
    );
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
