import 'package:flutter/material.dart';
import 'package:resturant/data/sample_data.dart';
import 'package:resturant/models/product_model.dart';
import 'package:resturant/widgets/search_result_list_item.dart';
// import 'package:speech_to_text/speech_to_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  // final SpeechToText _speechToText = SpeechToText();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  // bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    // _initSpeech();
    // Load all products initially
    _allProducts = SampleData.products;
    _filteredProducts = _allProducts;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // /// Initializes the speech-to-text engine
  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   setState(() {});
  // }

  // /// Starts a speech recognition session
  // void _startListening() async {
  //   await _speechToText.listen(
  //     onResult: (result) {
  //       setState(() {
  //         _searchController.text = result.recognizedWords;
  //         _searchController.selection = TextSelection.fromPosition(
  //           TextPosition(offset: _searchController.text.length),
  //         );
  //       });
  //     },
  //   );
  //   setState(() {});
  // }

  // /// Stops the listening session
  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }

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
                // The microphone button
                // suffixIcon: IconButton(
                //   icon: Icon(
                //     _speechToText.isListening ? Icons.mic_off : Icons.mic,
                //     color: _speechEnabled ? Colors.orange : Colors.grey,
                //   ),
                //   onPressed: _speechEnabled
                //       ? (_speechToText.isNotListening
                //             ? _startListening
                //             : _stopListening)
                //       : null, // Disable if speech not enabled
                // ),
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
                      return SearchResultListItem(
                        product: _filteredProducts[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
