class Product {
  final String name;
  final int price;

  const Product(this.name, this.price);

  @override
  int get hashCode => name.hashCode;
  
  @override
  bool operator ==(Object other) =>
    other is Product && other.name == name && other.price == price;

}

const stubProducts = [
  Product("Шаурма", 200),
  Product("Бургер", 250),
  Product("Картошка фри", 100),
  Product("Кола", 50),
  Product("Фанта", 60),
];