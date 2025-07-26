import 'package:flutter/material.dart';
import 'package:resturant/models/cart_item_model.dart';
import 'package:resturant/services/cart_service.dart';
import 'package:resturant/widgets/cart_list_item.dart';
import 'package:resturant/widgets/order_summary_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();

  // --- NEW STATE VARIABLES ---
  // We hold the list of items directly, not the future.
  List<CartItem>? _cartItems;
  // We use a boolean to manually control the loading indicator.
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Fetch the initial cart data when the screen is first built.
    _fetchCartItems();
  }

  // --- RENAMED AND UPDATED REFRESH METHOD ---
  Future<void> _fetchCartItems() async {
    // Set the state to loading *before* fetching the data
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final items = await _cartService.getCartItems();
      // If successful, update the state with the new data
      if (mounted) {
        setState(() {
          _cartItems = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      // If an error occurs, update the state with the error message
      if (mounted) {
        setState(() {
          _error = "Failed to load cart items.";
          _isLoading = false;
        });
      }
    }
  }

  // --- ADD THIS NEW METHOD ---
  // This method handles the entire order placement flow.
  Future<void> _placeOrder() async {
    // 1. Show a confirmation dialog to the user.
    await showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Confirmed!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Thank you for your purchase.'),
                Text('Your order has been placed successfully.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );

    // 2. Clear the cart from storage.
    await _cartService.clearCart();

    // 3. Refresh the UI to show the "Your cart is empty" message.
    _fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Order details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // --- REPLACED FutureBuilder WITH MANUAL CHECKS ---
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }
    if (_cartItems == null || _cartItems!.isEmpty) {
      return const Center(child: Text('Your cart is empty.'));
    }

    // If we have data, we build the main UI
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _cartItems!.length,
            itemBuilder: (context, index) {
              final cartItem = _cartItems![index];
              return CartListItem(
                cartItem: cartItem,
                onQuantityChanged: (newQuantity) {
                  // The update logic is the same, but now it triggers our
                  // new, flicker-free refresh method.
                  _cartService
                      .updateQuantity(cartItem.product.id, newQuantity)
                      .then((_) => _fetchCartItems());
                },
              );
            },
          ),
        ),
        // Pass the new _placeOrder method to the OrderSummaryCard
        OrderSummaryCard(
          cartItems: _cartItems!,
          onPlaceOrderPressed: _placeOrder, // <-- UPDATE THIS LINE
        ),
      ],
    );
  }
}

// // lib/screens/cart_screen.dart (Final Version)

// import 'package:flutter/material.dart';
// import 'package:resturant/models/cart_item_model.dart';
// import 'package:resturant/services/cart_service.dart';
// import 'package:resturant/widgets/cart_list_item.dart';
// import 'package:resturant/widgets/order_summary_card.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final CartService _cartService = CartService();
//   late Future<List<CartItem>> _cartItemsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _refreshCart();
//   }

//   void _refreshCart() {
//     setState(() {
//       _cartItemsFuture = _cartService.getCartItems();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         title: const Text(
//           'Order details',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: FutureBuilder<List<CartItem>>(
//         future: _cartItemsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('Your cart is empty.'));
//           }

//           final cartItems = snapshot.data!;
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: cartItems.length,
//                   itemBuilder: (context, index) {
//                     final cartItem = cartItems[index];
//                     return CartListItem(
//                       cartItem: cartItem,
//                       onQuantityChanged: (newQuantity) {
//                         _cartService
//                             .updateQuantity(cartItem.product.id, newQuantity)
//                             .then(
//                               (_) => _refreshCart(),
//                             ); // Refresh UI after update
//                       },
//                     );
//                   },
//                 ),
//               ),
//               OrderSummaryCard(cartItems: cartItems),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
