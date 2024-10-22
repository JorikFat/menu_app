import 'package:menu_app/features/product.dart';

class CatalogProvider {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return const [
      Product("Шаурма", 200),
      Product("Бургер", 250),
      Product("Картошка фри", 100),
      Product("Кола", 50),
      Product("Фанта", 60),
    ];
  }
}
