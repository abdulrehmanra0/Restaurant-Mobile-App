// lib/widgets/order_summary_card.dart

import 'package:flutter/material.dart';
import 'package:resturant/models/cart_item_model.dart';

class OrderSummaryCard extends StatelessWidget {
  final List<CartItem> cartItems;
  const OrderSummaryCard({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final double subTotal = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    const double deliveryCharge = 50.0;
    const double discount = 0.0;
    final double total = subTotal + deliveryCharge - discount;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
        // You can add a subtle background image here if you have one
      ),
      child: Column(
        children: [
          _buildSummaryRow('Sub-Total', subTotal),
          _buildSummaryRow('Delivery Charge', deliveryCharge),
          _buildSummaryRow('Discount', discount),
          const Divider(color: Colors.white54, thickness: 1, height: 24),
          _buildSummaryRow('Total', total, isTotal: true),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Place My Order',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, double value, {bool isTotal = false}) {
    final style = TextStyle(
      color: Colors.white,
      fontSize: isTotal ? 20 : 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text('Rs ${value.toStringAsFixed(0)}', style: style),
        ],
      ),
    );
  }
}
