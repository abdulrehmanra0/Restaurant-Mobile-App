import 'package:resturant/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // Methods to convert CartItem to and from a Map for JSON storage
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(
        json['product'],
      ), // We need to add fromJson to Product model
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(), // We need to add toJson to Product model
      'quantity': quantity,
    };
  }
}
