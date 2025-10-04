import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_app/features/cart/amount/amount_bloc.dart';
import 'package:menu_app/features/cart/cart.dart';
import 'package:menu_app/features/cart/cart_interactor.dart';
import 'package:menu_app/features/cart/count/cart_count_cubit.dart';
import 'package:menu_app/features/cart/list/cart_list_bloc.dart';
import 'package:provider/provider.dart';

final cartProviders = [
  Provider<Cart>(
    create: (_) => Cart(),
  ),
  Provider<CartInteractor>(
    create: (context) => CartInteractor(context.read<Cart>()),
  ),
  BlocProvider<CartListBloc>(
    create: (context) => CartListBloc(context.read<CartInteractor>()),
  ),
  BlocProvider<CartCountCubit>(
    create: (context) => CartCountCubit(context.read<CartInteractor>()),
  ),
  BlocProvider<AmountBloc>(
    create: (context) => AmountBloc(context.read<CartInteractor>()),
  ),
];
