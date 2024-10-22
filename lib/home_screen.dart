import 'package:flutter/material.dart';
import 'package:menu_app/core.dart';
import 'package:menu_app/features/catalog/catalog_bloc.dart';
import 'package:menu_app/features/catalog/catalog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  final CatalogBloc catalog = CatalogBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(APP_NAME),),
      body: CatalogWidget(catalog),
    );
  }

}