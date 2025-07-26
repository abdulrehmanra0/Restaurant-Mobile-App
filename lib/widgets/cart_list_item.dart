// lib/widgets/cart_list_item.dart

import 'package:flutter/material.dart';
import 'package:resturant/models/cart_item_model.dart';

class CartListItem extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;

  const CartListItem({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              cartItem.product.imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  cartItem.product.shortDescription,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rs ${cartItem.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Quantity Selector
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.orange),
                  onPressed: () => onQuantityChanged(cartItem.quantity - 1),
                  iconSize: 18,
                ),
                Text(
                  cartItem.quantity.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.orange),
                  onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                  iconSize: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
