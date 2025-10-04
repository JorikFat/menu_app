class Product {
  final String name;
  final int price;

  const Product(this.name, this.price);

  @override
  String toString() => '$runtimeType: $name, price:$price';

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.name == name && other.price == price;
  }
}
