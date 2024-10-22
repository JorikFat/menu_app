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