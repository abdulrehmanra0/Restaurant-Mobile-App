import 'package:flutter/material.dart';
import 'package:resturant/data/sample_data.dart';
import 'package:resturant/screens/cart_screen.dart'; // We need to import the cart screen
import 'package:resturant/screens/login_screen.dart';
import 'package:resturant/services/cart_service.dart';
import 'package:resturant/services/auth_service.dart';
import 'package:resturant/widgets/food_item_card.dart';
import 'package:resturant/widgets/promo_banner_card.dart';
import 'package:resturant/screens/search_screen.dart'; // <-- ADD THIS IMPORT

//******************************************************************
// MainScreen is the new "host" widget with the Bottom Navigation Bar
//******************************************************************
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _cartItemCount = 0; // State variable to hold the cart count
  final CartService _cartService = CartService();

  // List of the pages that the bottom bar will navigate between
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardPage(), // Your original menu UI is now here
    const SearchScreen(), // <-- REPLACE the Text widget with this
    const CartScreen(), // The screen for order details
  ];

  @override
  void initState() {
    super.initState();
    _updateCartCount(); // Get the initial cart count when the screen loads
  }

  // A method to fetch and update the cart count
  void _updateCartCount() async {
    final items = await _cartService.getCartItems();
    if (mounted) {
      setState(() {
        _cartItemCount = items.fold(0, (sum, item) => sum + item.quantity);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Refresh the cart count every time the user navigates,
    // especially when they might be coming back from adding an item.
    _updateCartCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            // Use a regular icon, but wrap it in our dynamic Badge
            icon: Badge(
              label: Text('$_cartItemCount'),
              isLabelVisible:
                  _cartItemCount > 0, // Only show badge if cart has items
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            activeIcon: Badge(
              label: Text('$_cartItemCount'),
              isLabelVisible: _cartItemCount > 0,
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Good for 3-5 items
      ),
    );
  }
}

//*********************************************************************
// DashboardPage contains the UI from your old MenuScreen
//*********************************************************************
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // IMPORTANT: We return the CustomScrollView directly, NOT a Scaffold.
    // The Scaffold is now provided by MainScreen.
    return CustomScrollView(
      slivers: [
        // The App Bar with the "Dashboard" title AND the new logout button
        SliverAppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Colors.white,
          pinned: true,
          elevation: 0,
          // THIS IS THE NEW PART
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black54),
              onPressed: () async {
                final authService = AuthService();
                await authService.signOut();
                // Navigate back to Login and remove all previous screens from history
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),

        // 2. The Promo Banner Card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PromoBannerCard(product: SampleData.specialOffer),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // 3. The Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for food, restaurants...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[100],
                filled: true,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // 4. "Best Offers" Section Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Best Offers 🔥',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('See all')),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // 5. Horizontally Scrolling List of Food Items
        SliverToBoxAdapter(
          child: SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: SampleData.products.length,
              itemBuilder: (context, index) {
                final product = SampleData.products[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16.0 : 8.0,
                    right: index == SampleData.products.length - 1 ? 16.0 : 8.0,
                  ),
                  child: FoodItemCard(product: product),
                );
              },
            ),
          ),
        ),

        // 6. TODO: Add the "Explore more" section here
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:resturant/data/sample_data.dart';
// import 'package:resturant/widgets/food_item_card.dart'; // Assuming this is your card's file
// import 'package:resturant/widgets/promo_banner_card.dart'; // Assuming this is your banner's file
// // We will create the detail screen in the next step
// // import 'package:restaurant_app/screens/product_detail_screen.dart';

// class MenuScreen extends StatelessWidget {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // The CustomScrollView allows us to mix different scrolling widgets (slivers)
//       body: CustomScrollView(
//         slivers: [
//           // 1. The App Bar with the "Dashboard" title
//           const SliverAppBar(
//             title: Text(
//               'Dashboard',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             backgroundColor: Colors.white,
//             pinned: true, // Keeps the app bar visible
//             elevation: 0,
//           ),

//           // 2. The Promo Banner Card (using SliverToBoxAdapter to place a single widget)
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: PromoBannerCard(product: SampleData.specialOffer),
//             ),
//           ),

//           // SliverToBoxAdapter for adding some vertical space
//           const SliverToBoxAdapter(child: SizedBox(height: 24)),

//           // 3. The Search Bar (a placeholder for now)
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search for food, restaurants...',
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: const Icon(Icons.mic),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   fillColor: Colors.grey[100],
//                   filled: true,
//                 ),
//               ),
//             ),
//           ),

//           const SliverToBoxAdapter(child: SizedBox(height: 24)),

//           // 4. "Best Offers" Section Header
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Best Offers 🔥',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(onPressed: () {}, child: const Text('See all')),
//                 ],
//               ),
//             ),
//           ),

//           const SliverToBoxAdapter(child: SizedBox(height: 16)),

//           // 5. Horizontally Scrolling List of Food Items
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 240, // Important: Give the horizontal list a fixed height
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: SampleData.products.length,
//                 itemBuilder: (context, index) {
//                   final product = SampleData.products[index];
//                   return Padding(
//                     padding: EdgeInsets.only(
//                       left: index == 0 ? 16.0 : 8.0,
//                       right: index == SampleData.products.length - 1
//                           ? 16.0
//                           : 8.0,
//                     ),
//                     child: FoodItemCard(product: product), // Your custom card
//                   );
//                 },
//               ),
//             ),
//           ),

//           // 6. TODO: Add the "Explore more" section here following the same pattern
//         ],
//       ),
//       // We will add the BottomNavigationBar in a later step
//       // bottomNavigationBar: ...,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:resturant/services/auth_service.dart';
// import 'package:resturant/screens/login_screen.dart';

// class MenuScreen extends StatelessWidget {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthService authService = AuthService();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Menu'),
//         backgroundColor: Colors.orange,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await authService.signOut();
//               // Navigate back to Login Screen and remove all previous routes
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 (Route<dynamic> route) => false,
//               );
//             },
//           ),
//         ],
//       ),
//       body: const Center(child: Text('Welcome to the Restaurant!')),
//     );
//   }
// }
