import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/amount/amount_widget.dart';
import 'package:menu_app/features/cart/list/cart_list_bloc.dart';
import 'package:menu_app/features/cart/list/cart_list_events.dart';
import 'package:menu_app/features/cart/list/cart_list_states.dart';

class CartListWidget extends StatelessWidget {
  const CartListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartListBloc, CartListState>(
      builder: (context, state) => switch (state) {
        CartEmptyState() => const CartEmptyWidget(),
        CartDataState() => _List(
            products: state.list,
            onIncrement: (product) => context
                .read<CartListBloc>()
                .add(CartListAddProductEvent(product)),
            onDecrement: (product) => context
                .read<CartListBloc>()
                .add(CartListRemoveProductEvent(product)),
          ),
      },
    );
  }
}

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Корзина пуста"),
    );
  }
}

class _List extends StatelessWidget {
  final List<ProductCartViewState> products;
  final void Function(ProductCartViewState product) onIncrement;
  final void Function(ProductCartViewState product) onDecrement;

  const _List({
    super.key,
    required this.products,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final ProductCartViewState product = products[index];
              return _CartProduct(
                state: product,
                increment: () => onIncrement(product),
                decrement: () => onDecrement(product),
              );
            },
          ),
        ),
        const AmountWidget(),
      ],
    );
  }
}

class _CartProduct extends StatelessWidget {
  final ProductCartViewState state;
  final VoidCallback increment;
  final VoidCallback decrement;

  const _CartProduct({
    required this.state,
    required this.increment,
    required this.decrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: Text(state.name)),
            IconButton(onPressed: decrement, icon: const Icon(Icons.remove)),
            Text(state.count),
            IconButton(onPressed: increment, icon: const Icon(Icons.add)),
            Expanded(child: Text(state.amount, textAlign: TextAlign.end)),
          ],
        ),
      ),
    );
  }
}
