import 'package:flutter/material.dart';
import 'package:resturant/models/product_model.dart';
import 'package:resturant/services/cart_service.dart';
import 'package:resturant/widgets/custom_button.dart'; // We'll reuse our button

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              product.imagePath,
              height: screenHeight * 0.45,
              fit: BoxFit.cover,
            ),
          ),

          // 2. Back Button
          Positioned(
            top: 40, // Adjust for status bar
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.5),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          // 3. Draggable Content Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.6, // Start at 60% of the screen height
            minChildSize: 0.6, // Don't let it shrink below 60%
            maxChildSize: 0.9, // Can be dragged up to 90%
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                // Use a ListView for its scrolling physics
                child: ListView(
                  controller: scrollController, // Connect the controller!
                  children: [
                    // Drag Handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        height: 5.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "Popular" Tag and Icons
                          Row(
                            children: [
                              if (product.isPopular)
                                Chip(
                                  label: const Text('Popular'),
                                  backgroundColor: Colors.green.withOpacity(
                                    0.1,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.green,
                                  ),
                                  side: BorderSide.none,
                                ),
                              const Spacer(),
                              const Icon(
                                Icons.share_outlined,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Product Title
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Rating and Order Count
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${product.rating} Rating',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 24),
                              const Icon(
                                Icons.shopping_bag,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${(product.orderCount / 1000).toStringAsFixed(0)}k+ Order',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Description
                          Text(
                            product.longDescription,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5, // Line spacing
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Add to Cart Button
                          CustomButton(
                            text: 'Add to Cart',
                            onPressed: () {
                              final cartService = CartService();
                              cartService.addToCart(product).then((_) {
                                // Show a confirmation message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.name} added to cart!',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                                // NOTE: The badge will automatically update when the user
                                // taps a button on the bottom navigation bar because of the
                                // change we made previously.
                              });
                            },
                          ),
                          const SizedBox(height: 24), // Padding at the bottom
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
