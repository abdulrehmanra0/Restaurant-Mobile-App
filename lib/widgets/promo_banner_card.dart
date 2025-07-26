import 'package:flutter/material.dart';
import 'package:resturant/models/product_model.dart';

class PromoBannerCard extends StatelessWidget {
  final Product product;

  const PromoBannerCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.asset(
        product
            .bannerImagePath, // Using the banner image path from our data model
        fit: BoxFit.cover,
      ),
    );
  }
}
