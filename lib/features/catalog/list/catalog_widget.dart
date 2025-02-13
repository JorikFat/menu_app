import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/catalog/list/catalog_cubit.dart';
import 'package:menu_app/features/catalog/list/catalog_state.dart';
import 'package:menu_app/features/product.dart';
import 'package:menu_app/widgets_ext.dart';

class CatalogWidget extends StatelessWidget {
  final CatalogCubit cubit;

  const CatalogWidget(this.cubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      bloc: cubit,
      builder: (context, state) => switch (state) {
        CatalogLoadState() => const _Load(),
        CatalogDataState() => _List(
            products: state.products,
            onTap: cubit.addProduct,
          ),
      },
    );
  }
}

class _List extends StatelessWidget {
  final List<CartProduct> products;
  final void Function(Product product) onTap;

  const _List({
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
        final CartProduct product = products[index];
        return InkWell(
          onTap: () => onTap(product),
          child: _Product(product).badge(product.count),
        );
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
