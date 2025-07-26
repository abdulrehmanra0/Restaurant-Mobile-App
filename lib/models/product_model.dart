// lib/models/product_model.dart

class Product {
  final String id;
  final String name;
  final String shortDescription; // For the card, e.g., "Some Details"
  final String longDescription; // For the detail screen
  final String imagePath; // Main image for the item
  final String bannerImagePath; // Optional: for promo banners
  final double price;
  final double rating;
  final int orderCount;
  final bool isPopular;

  Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.imagePath,
    this.bannerImagePath = '', // Default to empty
    required this.price,
    this.rating = 0.0,
    this.orderCount = 0,
    this.isPopular = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      shortDescription: json['shortDescription'],
      longDescription: json['longDescription'],
      imagePath: json['imagePath'],
      bannerImagePath: json['bannerImagePath'] ?? '',
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      orderCount: json['orderCount'],
      isPopular: json['isPopular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'imagePath': imagePath,
      'bannerImagePath': bannerImagePath,
      'price': price,
      'rating': rating,
      'orderCount': orderCount,
      'isPopular': isPopular,
    };
  }
}
