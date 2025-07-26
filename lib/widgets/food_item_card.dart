import 'package:flutter/material.dart';
import 'package:resturant/models/product_model.dart';
import 'package:resturant/screens/product_detail_screen.dart'; // We will create this next

class FoodItemCard extends StatelessWidget {
  final Product product;
  const FoodItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // This is the navigation logic to the detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: SizedBox(
        width: 180, // Giving the card a fixed width
        child: Stack(
          clipBehavior:
              Clip.none, // Allows widgets to overflow the Stack boundaries
          children: [
            // The main white container card
            Positioned(
              top:
                  50, // Start the card 50px from the top to leave space for the image
              left: 0,
              right: 0,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    60,
                    16,
                    16,
                  ), // Top padding for image
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.shortDescription,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Rs ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.price.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // The food image that overflows the card
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      product.imagePath,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
