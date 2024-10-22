import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/cart_bloc.dart';
import 'package:menu_app/features/cart/cart_events.dart';
import 'package:menu_app/features/cart/cart_product.dart';
import 'package:menu_app/features/cart/cart_states.dart';

class CartWidget extends StatelessWidget {
  final CartBloc bloc;

  const CartWidget(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        bloc: bloc,
        builder: (context, state) => switch(state){
          CartEmptyState() => const _Empty(),
          CartDataState() => ListView.separated(
            itemCount: state.products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) => _CartProduct(
              product: state.products[index],
              increment: () => bloc.add(CartAddProductEvent(state.products[index])),
              decrement: () => bloc.add(CartRemoveProductEvent(state.products[index])),
            ),
          ),
        });
  }
}

class _Empty extends StatelessWidget {
  const _Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Корзина пуста"),);
  }

}

class _CartProduct extends StatelessWidget {
  final CartProduct product;
  final VoidCallback increment;
  final VoidCallback decrement;

  const _CartProduct({
    required this.product,
    required this.increment,
    required this.decrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(product.name),
            ),
            IconButton(onPressed: decrement, icon: const Icon(Icons.remove)),
            Text(product.count.toString()),
            IconButton(onPressed: decrement, icon: const Icon(Icons.add)),
            Text('сумма:${product.amount}р')
          ],
        ),
      ),
    );
  }
}