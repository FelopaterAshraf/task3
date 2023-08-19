
class Product {
  int price;
  String description;
  String thumbnail;

  Product({
    required this.price,
    required this.description,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      price: json['price'],
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }
}