import 'package:flutter/material.dart';
import 'package:resturant/data/sample_data.dart';
import 'package:resturant/models/product_model.dart';
// --- ADD THIS IMPORT ---
import 'package:resturant/screens/product_detail_screen.dart';
import 'package:resturant/widgets/search_result_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();

    _allProducts = SampleData.products;
    _filteredProducts = _allProducts;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filters the list of products based on the search query
  void _filterProducts() {
    final query = _searchController.text;
    if (query.isEmpty) {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Food')),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          // Search Results
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(child: Text('No products found.'))
                : ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];

                      // --- THIS IS THE KEY CHANGE ---
                      // We wrap the list item in a GestureDetector to make it tappable.
                      return GestureDetector(
                        onTap: () {
                          // When tapped, navigate to the ProductDetailScreen
                          // and pass the specific product that was tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        // We set the behavior to translucent to make sure the
                        // entire row area is tappable, not just the visible parts.
                        behavior: HitTestBehavior.translucent,
                        child: SearchResultListItem(product: product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
