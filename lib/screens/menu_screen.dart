import 'package:flutter/material.dart';
import 'package:resturant/data/sample_data.dart';
import 'package:resturant/screens/cart_screen.dart'; // We need to import the cart screen
import 'package:resturant/screens/login_screen.dart';
import 'package:resturant/services/cart_service.dart';
import 'package:resturant/services/auth_service.dart';
import 'package:resturant/widgets/food_item_card.dart';
import 'package:resturant/widgets/promo_banner_card.dart';
import 'package:resturant/screens/search_screen.dart'; // <-- ADD THIS IMPORT

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

        // --- THIS IS THE SECTION TO UPDATE ---
        // 3. The Search Bar (now a tappable navigation button)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // We use a GestureDetector to detect taps on the entire bar.
            child: GestureDetector(
              onTap: () {
                // When tapped, we navigate to the actual SearchScreen.
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              // This Container is styled to look exactly like a text field.
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600]),
                    const SizedBox(width: 10),
                    Text(
                      'Search for food, restaurants...',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    const Spacer(), // Pushes the mic icon to the end
                    Icon(Icons.mic, color: Colors.grey[600]),
                  ],
                ),
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
