import 'package:flutter/material.dart';
import 'package:resturant/models/product_model.dart';
class SearchResultListItem extends StatelessWidget {
final Product product;
const SearchResultListItem({super.key, required this.product});
@override
Widget build(BuildContext context) {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
child: Row(
children: [
ClipRRect(
borderRadius: BorderRadius.circular(12),
child: Image.asset(product.imagePath, width: 80, height: 80, fit: BoxFit.cover),
),
const SizedBox(width: 16),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
Text(
'Rs ${product.price.toStringAsFixed(0)}',
style: TextStyle(fontSize: 16, color: Colors.grey[700]),
),
],
),
),
const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
],
),
);
}
}