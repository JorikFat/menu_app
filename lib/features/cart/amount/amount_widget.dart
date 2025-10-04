import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/amount/amount_bloc.dart';
import 'package:menu_app/features/cart/amount/amount_events.dart';
import 'package:menu_app/features/cart/amount/amount_state.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountBloc, AmountState>(
      builder: (context, state) => Row(
        children: [
          Expanded(child: _Amount(state.text)),
          const SizedBox(width: 10),
          _Purchase(
            () => context.read<AmountBloc>().add(const AmountPurchaseEvent()),
          )
        ],
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  final String text;

  const _Amount(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      );
}

class _Purchase extends StatelessWidget {
  final VoidCallback callback;

  const _Purchase(this.callback, {super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      child: const Text("Заказать"),
    );
  }
}
